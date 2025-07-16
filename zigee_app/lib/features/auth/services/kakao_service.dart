import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoService {
  Future<void> loginWithKakaoTalk() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();

      debugPrint('[카카오톡으로 로그인 성공]');
    } catch (error) {
      debugPrint('[카카오톡으로 로그인 실패]');
      debugPrint('[$error');

      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }

      await loginWithKakaoAccount();
    }
  }

  Future<void> loginWithKakaoAccount() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      debugPrint('[카카오 계정으로 로그인 성공]');
    } catch (error) {
      debugPrint('[카카오 계정으로 로그인 실패]');
      debugPrint('$error');
    }
  }

  Future<void> signInWithKakao() async {
    try {
      final isKakaoTalkAvailable = await isKakaoTalkInstalled();

      if (isKakaoTalkAvailable) {
        await loginWithKakaoTalk();
      } else {
        await loginWithKakaoAccount();
      }
    } catch (error) {
      debugPrint('[카카오 로그인 실패]');
      debugPrint('$error');
    }
  }
}
