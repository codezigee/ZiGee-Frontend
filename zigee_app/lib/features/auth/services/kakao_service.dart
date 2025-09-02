import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:zigee_app/features/auth/models/auth_provider_type.dart';
import 'package:zigee_app/features/auth/models/auth_result.dart';
import 'package:zigee_app/features/auth/models/auth_token.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    hide Options;
import 'package:dio/dio.dart';
import 'dart:convert';

// TODO: - 하드코딩된 expireAt 값 수정 필요

class KakaoService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late final Dio _dio;

  static const String _accessTokenKey = 'jwt_access_token_key';
  static const String _refreshTokenKey = 'jwt_refresh_token_key';
  static const String _baseUrl = 'https://zigee.api.baseurl';

  KakaoService() {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl)); // Dio 인스턴스 초기화 (baseUrl 설정)
    _setupInterceptors();
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

  // 카카오톡 설치 여부 확인 후 로그인 시도
  Future<AuthResult> loginWithKakao() async {
    try {
      final isKakaoTalkAvailable = await isKakaoTalkInstalled();
      AuthResult kakaoResult;

      if (isKakaoTalkAvailable) {
        kakaoResult = await loginWithKakaoTalk();
      } else {
        kakaoResult = await loginWithKakaoAccount();
      }

      if (kakaoResult is AuthSuccess) {
        return await exchangeKakaoToken(kakaoResult.token);
      } else {
        return kakaoResult;
      }
    } catch (error) {
      return AuthFailure(AuthError.unknown(error.toString()));
    }
  }

  // 카카오톡 앱 로그인
  Future<AuthResult> loginWithKakaoTalk() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      AuthToken authToken = AuthToken(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
        expireAt: DateTime.now().add(const Duration(hours: 1)),
      );
      return AuthSuccess(
        token: authToken,
        providerType: AuthProviderType.kakao,
      );
    } catch (error) {
      if (error is PlatformException) {
        switch (error.code) {
          case 'CANCELED':
            return AuthCancelled();
          case 'NOT_INSTALLED':
            return AuthFailure(AuthError.notInstalled(error.message));
          case 'NETWORK_ERROR':
            return AuthFailure(AuthError.networkError(error.message));
          case 'TOKEN_EXPIRED':
            return AuthFailure(AuthError.tokenExpired(error.message));
          case 'PERMISSION_DENIED':
            return AuthFailure(AuthError.permissionDenied(error.message));
          default:
            break;
        }
      }
      return AuthFailure(AuthError.unknown(error.toString()));
    }
  }

  // 카카오톡 계정 로그인(웹뷰)
  Future<AuthResult> loginWithKakaoAccount() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      AuthToken authToken = AuthToken(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
        expireAt: DateTime.now().add(const Duration(hours: 1)),
      );
      return AuthSuccess(
        token: authToken,
        providerType: AuthProviderType.kakao,
      );
    } catch (error) {
      if (error is PlatformException) {
        switch (error.code) {
          case 'CANCELED':
            return AuthCancelled();
          case 'NETWORK_ERROR':
            return AuthFailure(AuthError.networkError(error.message));
          case 'TOKEN_EXPIRED':
            return AuthFailure(AuthError.tokenExpired(error.message));
          case 'PERMISSION_DENIED':
            return AuthFailure(AuthError.permissionDenied(error.message));
          default:
            break;
        }
      }
      return AuthFailure(AuthError.unknown(error.toString()));
    }
  }

  // 카카오 토큰을 백엔드 서버로 보내 JWT 토큰 발급 요청
  Future<AuthResult> exchangeKakaoToken(AuthToken token) async {
    try {
      final response = await _dio.post(
        '/api/auth/login',
        data: {'access_token': token.accessToken},
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
        return AuthSuccess(
          token: AuthToken(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
            expireAt: DateTime.now().add(const Duration(hours: 1)),
          ),
          providerType: AuthProviderType.kakao,
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

        final dummyToken = AuthToken(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
          expireAt: DateTime.now().add(const Duration(hours: 1)),
        );
        return AuthSuccess(
          token: dummyToken,
          providerType: AuthProviderType.kakao,
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
          providerType: AuthProviderType.kakao,
        );
      }

      return AuthFailure(AuthError.unknown('사용자 정보 조회 실패'));
    } catch (error) {
      return AuthFailure(AuthError.unknown(error.toString()));
    }
  }

  // 로그아웃
  Future<AuthResult> logout() async {
    try {
      await UserApi.instance.logout();
      await clearTokens();

      return AuthSuccess(
        token: AuthToken(accessToken: '', expireAt: DateTime(0)),
        providerType: AuthProviderType.kakao,
      );
    } catch (error) {
      return AuthFailure(AuthError.unknown(error.toString()));
    }
  }
}
