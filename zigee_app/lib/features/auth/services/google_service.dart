import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zigee_app/features/auth/models/auth_provider_type.dart';
import 'package:zigee_app/features/auth/models/auth_result.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    hide Options;
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:zigee_app/features/auth/models/auth_token.dart';

class GoogleService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late final Dio _dio;
  late final GoogleSignIn _googleSignIn;

  static const String _accessTokenKey = 'jwt_access_token_key';
  static const String _refreshTokenKey = 'jwt_refresh_token_key';
  static const String _baseUrl = 'https://zigee.api.baseurl';

  GoogleService() {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
    _googleSignIn = GoogleSignIn.instance;
    _setupInterceptors();
    _initializeGoogleSignIn();
  }

  Future<void> _initializeGoogleSignIn() async {
    try {
      await _googleSignIn.initialize(
        clientId:
            '739205439502-51tde7gh23ii3sc7jhrd1tbtqc841hu7.apps.googleusercontent.com',
      );
    } catch (e) {
      debugPrint('Google Sign-In 초기화 실패: $e');
    }
  }

  // JWT 토큰 자동 관리를 위한 Dio 인터셉터 설정
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        // 요청 전 처리: JWT 토큰을 Authorization 헤더에 자동 추가
        onRequest: (options, handler) async {
          final token = await getAccessToken();
          // 토큰이 존재하면 Authorization 헤더에 Bearer 토큰 추가
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        // 에러 처리: 401 Unauthorized 발생 시 토큰 갱신 시도
        onError: (error, handler) async {
          // 401 에러인 경우 토큰 만료로 판단하고 자동 갱신 시도
          if (error.response?.statusCode == 401) {
            final refreshResult = await refreshAccessToken();

            // 토큰 갱신 성공 시 원래 요청을 새 토큰으로 재시도
            if (refreshResult is AuthSuccess) {
              final newToken = await getAccessToken();
              final requestOptions = error.requestOptions;
              requestOptions.headers['Authorization'] = 'Bearer $newToken';

              // 새 토큰으로 원래 요청 재실행
              final response = await _dio.fetch(requestOptions);
              handler.resolve(response);
              return;
            } else {
              // 토큰 갱신 실패 시 저장된 모든 토큰 삭제 -> 로그아웃 처리
              await clearTokens();
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  // 구글 로그인 시도
  Future<AuthResult> loginWithGoogle() async {
    try {
      final GoogleSignInAccount googleAccount =
          await _googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth =
          googleAccount.authentication;

      if (googleAuth.idToken == null) {
        return AuthFailure(AuthError.unknown('구글 ID 토큰을 가져올 수 없음'));
      }

      return await exchangeGoogleToken(googleAuth.idToken!);
    } catch (error) {
      if (error is GoogleSignInException) {
        switch (error.code) {
          case GoogleSignInExceptionCode.canceled:
            return AuthCancelled();
          case GoogleSignInExceptionCode.clientConfigurationError:
            return AuthFailure(AuthError.unknown('클라이언트  설정 오류'));
          case GoogleSignInExceptionCode.providerConfigurationError:
            return AuthFailure(AuthError.serverError(500, '서비스 설정 오류'));
          case GoogleSignInExceptionCode.uiUnavailable:
            return AuthFailure(AuthError.unknown('UI를 표시할 수 없음'));
          case GoogleSignInExceptionCode.userMismatch:
            return AuthFailure(AuthError.unknown('사용자 불일치'));
          case GoogleSignInExceptionCode.interrupted:
            return AuthFailure(AuthError.unknown('로그인이 중단됨'));
          default:
            return AuthFailure(
              AuthError.unknown(error.description ?? '알 수 없는 구글 로그인 오류'),
            );
        }
      }

      if (error is PlatformException) {
        switch (error.code) {
          case 'sign_in_canceled':
            return AuthCancelled();
          case 'network_error':
            return AuthFailure(AuthError.networkError(error.message));
          case 'sign_in_failed':
            return AuthFailure(AuthError.unknown(error.message ?? '구글 로그인 실패'));
          default:
            return AuthFailure(
              AuthError.unknown(error.message ?? '알 수 없는 구글 로그인 오류'),
            );
        }
      }

      return AuthFailure(AuthError.unknown(error.toString()));
    }
  }

  // 구글 토큰을 백엔드 서버로 보내 JWT 토큰 발급 요청
  Future<AuthResult> exchangeGoogleToken(String idToken) async {
    try {
      final response = await _dio.post(
        '/api/auth/google/login',
        data: {'id_token': idToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        final data = response.data;
        final newAccessToken = data['jwt_access_token'];
        final newRefreshToken = data['jwt_refresh_token'];

        if (newAccessToken == null || newRefreshToken == null) {
          return AuthFailure(AuthError.invalidResponse());
        }

        await storeJWT(newAccessToken, newRefreshToken);
        final expireAt = DateTime.now().add(const Duration(hours: 1));
        return AuthSuccess(
          token: AuthToken(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
            expireAt: expireAt,
          ),
          providerType: AuthProviderType.google,
        );
      }

      if (statusCode == 401) {
        return AuthFailure(AuthError.tokenExpired());
      } else if (statusCode == 400) {
        return AuthFailure(AuthError.invalidResponse());
      } else if (statusCode != null && statusCode >= 500) {
        return AuthFailure(AuthError.serverError(statusCode));
      }
      return AuthFailure(AuthError.unknown('JWT 토큰 발급 실패'));
    } catch (error) {
      return AuthFailure(AuthError.unknown(error.toString()));
    }
  }

  // JWT 토큰 저장
  Future<void> storeJWT(String jwtToken, String refreshToken) async {
    await _storage.write(key: _accessTokenKey, value: jwtToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  // 액세스 토큰 가져오기
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  // 리프레시 토큰 가져오기
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  // 액세스 토큰 갱신
  Future<AuthResult> refreshAccessToken() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null) {
        return AuthFailure(AuthError.tokenExpired('Refresh token 만료'));
      }

      final response = await _dio.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        final data = response.data;
        final newAccessToken = data['jwt_access_token'];
        final newRefreshToken = data['jwt_refresh_token'];

        await storeJWT(newAccessToken, newRefreshToken);

        final expireAt = DateTime.now().add(const Duration(hours: 1));
        return AuthSuccess(
          token: AuthToken(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
            expireAt: expireAt,
          ),
          providerType: AuthProviderType.google,
        );
      }

      if (statusCode == 401) {
        return AuthFailure(AuthError.tokenExpired());
      } else if (statusCode == 400) {
        return AuthFailure(AuthError.invalidResponse());
      } else if (statusCode != null && statusCode >= 500) {
        return AuthFailure(AuthError.serverError(statusCode));
      }
      return AuthFailure(AuthError.unknown('JWT 토큰 발급 실패'));
    } catch (error) {
      return AuthFailure(AuthError.unknown(error.toString()));
    }
  }

  // JWT 토큰 삭제
  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  // 현재 로그인한 사용자 정보 가져오기
  Future<AuthResult> getCurrentUser() async {
    try {
      final response = await _dio.get('/api/members/1');
      if (response.statusCode == 200) {
        return AuthSuccess(
          token: AuthToken(accessToken: '', expireAt: DateTime.now()),
          providerType: AuthProviderType.google,
        ); // 수정
      }

      return AuthFailure(AuthError.unknown('사용자 정보 조회 실패'));
    } catch (error) {
      return AuthFailure(AuthError.unknown(error.toString()));
    }
  }

  // TODO: - 로그아웃 기능 구현
}
