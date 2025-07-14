import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_auth.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
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
                      onPressed: () async {
                        if (await isKakaoTalkInstalled()) {
                          try {
                            OAuthToken token =
                                await UserApi.instance.loginWithKakaoTalk();
                            debugPrint('[카카오톡으로 로그인 성공]');
                            debugPrint(
                              '[token.accessToken] ${token.accessToken}',
                            );
                            debugPrint(
                              '[token.refreshToken] ${token.refreshToken}',
                            );
                            debugPrint(
                              '[token.refreshTokenExpiresAt] ${token.refreshTokenExpiresAt}',
                            );
                          } catch (error) {
                            debugPrint('[카카오톡으로 로그인 실패]');
                            debugPrint('[$error');

                            // // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                            // // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                            // if (error is PlatformException &&
                            //     error.code == 'CANCELED') {
                            //   return;
                            // }
                            // // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                            try {
                              OAuthToken token =
                                  await UserApi.instance
                                      .loginWithKakaoAccount();
                              debugPrint('[카카오 계정으로 로그인 성공]');
                              debugPrint(
                                '[token.accessToken] ${token.accessToken}',
                              );
                              debugPrint(
                                '[token.refreshToken] ${token.refreshToken}',
                              );
                              debugPrint(
                                '[token.refreshTokenExpiresAt] ${token.refreshTokenExpiresAt}',
                              );
                            } catch (error) {
                              debugPrint('[카카오 계정으로 로그인 실패]');
                              debugPrint('$error');
                            }
                          }
                        } else {
                          try {
                            OAuthToken token =
                                await UserApi.instance.loginWithKakaoAccount();
                            debugPrint('[카카오 계정으로 로그인 성공]');
                            debugPrint(
                              '[token.accessToken] ${token.accessToken}',
                            );
                            debugPrint(
                              '[token.refreshToken] ${token.refreshToken}',
                            );
                            debugPrint(
                              '[token.refreshTokenExpiresAt] ${token.refreshTokenExpiresAt}',
                            );
                          } catch (error) {
                            debugPrint('[카카오 계정으로 로그인 실패]');
                            debugPrint('$error');
                          }
                        }
                      },
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
