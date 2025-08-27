import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/app/theme/typography_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/common/styles/button_styles.dart';

class RetryDialog {
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    String retryButtonText = '재시도',
    String cancelButtonText = '취소',
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizingTokens.radiusLg),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorTokens.backgroundPrimary,
                  borderRadius: BorderRadius.circular(SizingTokens.radiusSm),
                ),
                child: const Icon(
                  Icons.wifi_off_outlined,
                  color: ColorTokens.borderError,
                  size: 24,
                ),
              ),
              const SizedBox(width: SpacingTokens.sm),
              Text(
                title,
                style: TypographyStyles.titleLarge.copyWith(
                  fontWeight: TypographyTokens.bold,
                ),
              ),
            ],
          ),
          content: Text(message, style: TypographyStyles.bodyLarge),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: AppButtonStyles.secondary(),
              child: Text(cancelButtonText, style: TypographyStyles.labelLarge),
            ),
            const SizedBox(width: SpacingTokens.xs),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: AppButtonStyles.primary(),
              child: Text(
                retryButtonText,
                style: TypographyStyles.labelLarge.copyWith(
                  color: ColorTokens.textOnDark,
                ),
              ),
            ),
          ],
          actionsPadding: const EdgeInsets.fromLTRB(
            SpacingTokens.md,
            0,
            SpacingTokens.md,
            SpacingTokens.md,
          ),
        );
      },
    );
  }
}
