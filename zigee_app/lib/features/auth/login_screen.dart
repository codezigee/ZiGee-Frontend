import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/common/styles/button_styles.dart';
import 'package:zigee_app/common/styles/text_styles.dart';

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
                    ElevatedButton(
                      onPressed: () => debugPrint('카카오 로그인'),
                      // style: ButtonStyle(
                      //   textStyle: WidgetStatePropertyAll(AppTextStyles.labelLarge),
                      //   backgroundColor: const WidgetStatePropertyAll(
                      //     Color(0xFFFEE500),
                      //   ),
                      //   overlayColor: const WidgetStatePropertyAll(
                      //     Colors.transparent,
                      //   ),
                      //   elevation: const WidgetStatePropertyAll(0),
                      //   shape: WidgetStatePropertyAll(
                      //     RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(
                      //         SizingTokens.radiusMd,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      style: AppButtonStyles.primary().copyWith(
                        backgroundColor: const WidgetStatePropertyAll(
                          Color(0xFFFEE500),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/kakao_logo.png',
                            width: SizingTokens.buttonIconSize,
                            height: SizingTokens.buttonIconSize,
                            fit: BoxFit.contain,
                          ),
                          const Spacer(),
                          Text(
                            '카카오 로그인',
                            style: AppTextStyles.labelLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),

                    const SizedBox(height: SpacingTokens.layoutXs),

                    // 2. 구글 로그인
                    ElevatedButton(
                      onPressed: () => debugPrint('구글 로그인'),
                      style: AppButtonStyles.primary().copyWith(
                        backgroundColor: const WidgetStatePropertyAll(
                          Color(0xFFF2F2F2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/google_logo.png',
                            width: SizingTokens.buttonIconSize,
                            height: SizingTokens.buttonIconSize,
                            fit: BoxFit.contain,
                          ),
                          const Spacer(),
                          Text(
                            'Google 로그인',
                            style: AppTextStyles.labelLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),

                    const SizedBox(height: SpacingTokens.layoutXs),

                    // 3. 애플 로그인
                    ElevatedButton(
                      onPressed: () => debugPrint('애플 로그인'),
                      style: AppButtonStyles.secondary(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/apple_logo.png',
                            width: SizingTokens.buttonIconSize,
                            height: SizingTokens.buttonIconSize,
                            fit: BoxFit.contain,
                          ),
                          const Spacer(),
                          Text(
                            'Apple 로그인',
                            style: AppTextStyles.labelLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
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
