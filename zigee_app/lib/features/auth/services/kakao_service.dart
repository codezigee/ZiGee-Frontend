import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:zigee_app/features/auth/models/auth_result.dart';

class KakaoService {
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

  Future<AuthResult> signInWithKakao() async {
    try {
      final isKakaoTalkAvailable = await isKakaoTalkInstalled();
      if (isKakaoTalkAvailable) {
        return await loginWithKakaoTalk();
      } else {
        return await loginWithKakaoAccount();
      }
    } catch (error) {
      return AuthFailure(AuthError.unknown(error.toString()));
    }
  }
}
