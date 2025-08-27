import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/app/theme/typography_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/common/styles/button_styles.dart';
import 'package:zigee_app/features/auth/models/auth_result.dart';

class ErrorBottomSheet {
  static Future<void> show(
    BuildContext context, {
    required AuthError error,
    VoidCallback? onRetry,
    VoidCallback? onSupport,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: ColorTokens.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(SizingTokens.radiusXl),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(
            SpacingTokens.md,
            SpacingTokens.lg,
            SpacingTokens.md,
            SpacingTokens.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: ColorTokens.backgroundPrimary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: SpacingTokens.lg),

              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: ColorTokens.borderError,
                  borderRadius: BorderRadius.circular(SizingTokens.radiusXl),
                ),
                child: const Icon(
                  Icons.error_outline_rounded,
                  size: 40,
                  color: ColorTokens.borderError,
                ),
              ),
              const SizedBox(height: SpacingTokens.lg),

              Text(
                error.type.displayName,
                style: TypographyStyles.titleLarge.copyWith(
                  fontWeight: TypographyTokens.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SpacingTokens.sm),

              Text(
                error.message,
                style: TypographyStyles.bodyLarge.copyWith(
                  color: ColorTokens.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              if (error.statusCode != null) ...[
                const SizedBox(height: SpacingTokens.xs),
                Text(
                  '오류 코드: ${error.statusCode}',
                  style: TypographyStyles.bodySmall.copyWith(
                    color: ColorTokens.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],

              if (error.details != null) ...[
                const SizedBox(height: SpacingTokens.sm),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(SpacingTokens.sm),
                  decoration: BoxDecoration(
                    color: ColorTokens.backgroundPrimary,
                    borderRadius: BorderRadius.circular(SizingTokens.radiusLg),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    '상세 정보: ${error.details}',
                    style: TypographyStyles.bodySmall.copyWith(
                      color: ColorTokens.textSecondary,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: SpacingTokens.xl),

              Row(
                children: [
                  if (onSupport != null) ...[
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onSupport,
                        style: AppButtonStyles.secondary(),
                        icon: const Icon(Icons.help_outline, size: 18),
                        label: const Text(
                          '고객 지원',
                          style: TypographyStyles.labelLarge,
                        ),
                      ),
                    ),
                    const SizedBox(width: SpacingTokens.sm),
                  ],

                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onRetry ?? () => Navigator.of(context).pop(),
                      style: AppButtonStyles.primary(),
                      icon: Icon(
                        onRetry != null ? Icons.refresh : Icons.close,
                        size: 18,
                        color: ColorTokens.textOnDark,
                      ),
                      label: Text(
                        onRetry != null ? '다시 시도' : '닫기',
                        style: TypographyStyles.labelLarge.copyWith(
                          color: ColorTokens.textOnDark,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        );
      },
    );
  }
}
