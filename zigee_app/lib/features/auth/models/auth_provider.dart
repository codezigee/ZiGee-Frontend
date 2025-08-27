import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:zigee_app/features/auth/models/auth_result.dart';
import 'package:zigee_app/features/auth/services/kakao_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  final KakaoService _kakaoService = KakaoService();

  bool get isAuthenticated => _isAuthenticated;

  AuthProvider() {
    // 앱 시작 시 토큰 확인 및 자동 로그인 시도
    _initAuth();
  }

  Future<void> _initAuth() async {
    await checkAuthStatus();
  }

  Future<bool> login() async {
    try {
      final result = await _kakaoService.loginWithKakao();
      if (result is AuthSuccess) {
        _isAuthenticated = true;
      } else {
        return false;
      }

      notifyListeners(); // redirect 실행 -> 홈 화면으로 이동
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _kakaoService.logout();

      _isAuthenticated = false;
      notifyListeners(); // redirect 다시 실행 -> 로그인 화면으로 이동
    } catch (e) {
      debugPrint('[로그아웃 실패] $e');
    }
  }

  // 앱 시작 시 저장된 토큰 확인 및 유효성 검사
  Future<void> checkAuthStatus() async {
    try {
      // SecureStorage에서 저장된 토큰 확인
      final accessToken = await _kakaoService.getAccessToken();

      if (accessToken != null && accessToken.isNotEmpty) {
        // 실제 서버 API 호출로 토큰 유효성 검증 (인터셉터 작동 지점)
        final result = await _kakaoService.getCurrentUser();

        if (result is AuthSuccess) {
          _isAuthenticated = true;
          notifyListeners(); // redirect -> 홈 화면으로 이동
        } else {
          _isAuthenticated = false;
        }
      } else {
        _isAuthenticated = false;
      }
    } catch (e) {
      debugPrint('[토큰 확인 실패] $e');
      _isAuthenticated = false;
    }
  }
}
