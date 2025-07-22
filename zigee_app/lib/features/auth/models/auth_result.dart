import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

sealed class AuthResult {}

class AuthSuccess extends AuthResult {
  final OAuthToken token;
  AuthSuccess(this.token) {
    debugPrint('[로그인 성공]');
  }
}

class AuthFailure extends AuthResult {
  final AuthError error;
  AuthFailure(this.error) {
    debugPrint('[로그인 실패] ${error.message}');
  }
}

class AuthCancelled extends AuthResult {
  AuthCancelled() {
    debugPrint('[로그인 취소]');
  }
}

enum AuthErrorType {
  networkError,
  serverError,
  permissionDenied,
  tokenExpired,
  notInstalled,
  unknown,
}

class AuthError {
  final AuthErrorType type;
  final String message;
  final String? details;
  final int? statusCode;

  AuthError({
    required this.type,
    required this.message,
    this.details,
    this.statusCode,
  });

  factory AuthError.networkError([String? details]) {
    return AuthError(
      type: AuthErrorType.networkError,
      message: '네트워크 연결을 확인해주세요.',
      details: details,
    );
  }

  factory AuthError.serverError(int statusCode, [String? details]) {
    return AuthError(
      type: AuthErrorType.serverError,
      message: '서버에 일시적인 문제가 발생했습니다.',
      details: details,
      statusCode: statusCode,
    );
  }

  factory AuthError.permissionDenied([String? details]) {
    return AuthError(
      type: AuthErrorType.permissionDenied,
      message: '권한이 거부되었습니다.',
      details: details,
    );
  }

  factory AuthError.tokenExpired([String? details]) {
    return AuthError(
      type: AuthErrorType.tokenExpired,
      message: '인증 토큰이 만료되었습니다. 다시 로그인해주세요.',
      details: details,
    );
  }

  factory AuthError.notInstalled([String? details]) {
    return AuthError(
      type: AuthErrorType.notInstalled,
      message: '카카오톡이 설치되어 있지 않습니다.',
      details: details,
    );
  }

  factory AuthError.unknown([String? details]) {
    return AuthError(
      type: AuthErrorType.unknown,
      message: '알 수 없는 오류가 발생했습니다.',
      details: details,
    );
  }
}
