import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_auth.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:zigee_app/app/routes/app_routes.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/common/styles/button_styles.dart';
import 'package:zigee_app/common/styles/text_styles.dart';
import 'package:zigee_app/common/widgets/custom_loading_indicator.dart';
import 'package:zigee_app/common/widgets/custom_snackbar.dart';
import 'package:zigee_app/common/widgets/retry_dialog.dart';
import 'package:zigee_app/common/widgets/error_bottom_sheet.dart';
import 'package:zigee_app/features/auth/models/auth_result.dart';
import 'package:zigee_app/features/auth/services/kakao_service.dart';
import 'package:zigee_app/features/auth/widgets/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

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
                    const SizedBox(height: SpacingTokens.sm),
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
                    Stack(
                      children: [
                        SocialLoginButton(
                          text: '카카오 로그인',
                          assetPath: 'assets/images/kakao_logo.png',
                          backgroundColor: const Color(0xFFFEE500),
                          onPressed:
                              _isLoading ? null : () => _handleKakaoLogin(),
                          textStyle: AppTextStyles.labelLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_isLoading)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorTokens.borderFocus,
                                borderRadius: BorderRadius.circular(
                                  SizingTokens.radiusMd,
                                ),
                              ),
                              child: const CustomLoadingIndicator(),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: SpacingTokens.sm),

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

                    const SizedBox(height: SpacingTokens.sm),

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

  Future<void> _handleKakaoLogin() async {
    setState(() => _isLoading = true);

    try {
      final authResult = await KakaoService().loginWithKakao();

      if (!mounted) return;

      switch (authResult) {
        case AuthSuccess():
          context.push(AppRoutes.myBooking);
        case AuthFailure(error: final authError):
          await _handleAuthError(authError);
        case AuthCancelled():
          break;
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleAuthError(AuthError error) async {
    switch (error.type) {
      case AuthErrorType.networkError:
        final shouldRetry = await RetryDialog.show(
          context,
          title: '네트워크 연결 오류',
          message: '인터넷 연결을 확인하고 다시 시도해주세요.',
        );
        if (shouldRetry == true) {
          _handleKakaoLogin();
        }
        break;

      case AuthErrorType.serverError:
        await ErrorBottomSheet.show(
          context,
          error: error,
          onRetry: () {
            context.pop();
            _handleKakaoLogin();
          },
        );
        break;

      case AuthErrorType.tokenExpired:
        CustomSnackbar.showWarning(context, '인증 만료', '다시 로그인해주세요.');
        break;

      case AuthErrorType.permissionDenied:
        await ErrorBottomSheet.show(
          context,
          error: error,
          onRetry: () {
            context.pop();
            _handleKakaoLogin();
          },
        );
        break;

      case AuthErrorType.notInstalled:
        CustomSnackbar.showError(context, error);
        break;

      case AuthErrorType.invalidResponse:
        await ErrorBottomSheet.show(context, error: error);
        break;

      case AuthErrorType.unknown:
        CustomSnackbar.showError(context, error);
        break;
    }
  }
}
