import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/app/theme/typography_tokens.dart';
import 'package:zigee_app/common/widgets/custom_text_button.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String confirmText;
  final String cancelText;
  final Widget? icon;

  const CustomDialog({
    required this.title,
    required this.content,
    this.onConfirm,
    this.onCancel,
    this.confirmText = '확인',
    this.cancelText = '취소',
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizingTokens.radiusXxl),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TypographyStyles.titleLarge.copyWith(
                fontWeight: TypographyTokens.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: TypographyStyles.bodyLarge.copyWith(height: 1.3),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CustomTextButton.primary(
              onPressed: () {
                debugPrint('asdf');
              },
              label: '확인',
            ),
            const SizedBox(height: SpacingTokens.md),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onCancel ?? () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: ColorTokens.gray800,
                  side: const BorderSide(color: ColorTokens.gray300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(SizingTokens.radiusLg),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: SpacingTokens.md,
                  ),
                ),
                child: Text(cancelText),
              ),
            ),
            const SizedBox(height: SpacingTokens.sm),
          ],
        ),
      ),
    );
  }
}
