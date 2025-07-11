import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/common/styles/button_styles.dart';
import 'package:zigee_app/common/styles/text_styles.dart';
import 'package:zigee_app/features/auth/widgets/social_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(SpacingTokens.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('zigee', style: AppTextStyles.displayLarge),
                    const SizedBox(height: SpacingTokens.layoutXs),
                    Text(
                      '새싹(SeSAC) 성동 캠퍼스 회의실 예약 서비스',
                      style: AppTextStyles.titleMedium,
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    // 1. 카카오 로그인
                    SocialLoginButton(
                      text: '카카오 로그인',
                      assetPath: 'assets/images/kakao_logo.png',
                      backgroundColor: const Color(0xFFFEE500),
                      onPressed: () => debugPrint('카카오 로그인'),
                      textStyle: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: SpacingTokens.layoutXs),

                    // 2. 구글 로그인
                    SocialLoginButton(
                      text: 'Google 로그인',
                      assetPath: 'assets/images/google_logo.png',
                      backgroundColor: const Color(0xFFF2F2F2),
                      onPressed: () => debugPrint('구글 로그인'),
                      textStyle: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: SpacingTokens.layoutXs),

                    // 3. 애플 로그인
                    SocialLoginButton(
                      text: 'Apple 로그인',
                      assetPath: 'assets/images/apple_logo.png',
                      backgroundColor: Colors.white,
                      onPressed: () => debugPrint('애플 로그인'),
                      textStyle: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      buttonStyle: AppButtonStyles.secondary(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
