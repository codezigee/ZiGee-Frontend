import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:zigee_app/features/auth/models/auth_result.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    hide Options;
import 'package:dio/dio.dart';
import 'dart:convert';

class KakaoService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Dio _dio = Dio();

  static const String _accessTokenKey = 'jwt_access_token_key';
  static const String _refreshTokenKey = 'jwt_refresh_token_key';
  static const String _baseUrl = 'https://zigee.api.baseurl';

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
      return AuthSuccess(token);
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
      return AuthSuccess(token);
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
  Future<AuthResult> exchangeKakaoToken(OAuthToken kakaoToken) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/api/auth/login', // 임시 엔드포인트 URL
        data: {'access_token': kakaoToken.accessToken},
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
        return AuthSuccess(kakaoToken);
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

  // 액세스 토큰 유효성 검사
  Future<bool> validateAccessToken() async {
    final token = await getAccessToken();
    if (token == null) return false;

    try {
      final parts = token.split('.');
      if (parts.length != 3) return false;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final payloadMap = json.decode(decoded);

      final exp = payloadMap['exp'];
      if (exp == null) return false;

      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now().isBefore(expiryDate);
    } catch (error) {
      return false;
    }
  }

  // 액세스 토큰 갱신
  Future<AuthResult> refreshAccessToken() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null) {
        return AuthFailure(
          AuthError.tokenExpired('No refresh token available'),
        );
      }

      final response = await _dio.post(
        '$_baseUrl/auth/refresh',
        data: {'refresh_token': refreshToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        final data = response.data;
        final newAccessToken = data['jwt_access_token'];
        final newRefreshToken = data['jwt_refresh_token'];

        await storeJWT(newAccessToken, newRefreshToken);

        final dummyToken = OAuthToken(
          newAccessToken,
          DateTime(0, 6),
          newRefreshToken,
          DateTime(0, 6),
          [],
        );
        return AuthSuccess(dummyToken);
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

  // 로그아웃
  Future<AuthResult> logout() async {
    try {
      await UserApi.instance.logout();
      await clearTokens();
      final emptyToken = OAuthToken('', DateTime(0), '', DateTime(0), []);
      return AuthSuccess(emptyToken);
    } catch (error) {
      return AuthFailure(AuthError.unknown(error.toString()));
    }
  }
}
