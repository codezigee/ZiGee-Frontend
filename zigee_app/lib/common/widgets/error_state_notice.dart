import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/common/styles/text_styles.dart';
import 'package:zigee_app/common/widgets/custom_text_button.dart';

class ErrorStateNotice extends StatelessWidget {
  final String message;
  final String? buttonText;
  final VoidCallback? onRetry;

  const ErrorStateNotice({
    required this.message,
    this.buttonText,
    this.onRetry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 64, color: ColorTokens.red),
          const SizedBox(height: 8),
          Text(
            message,
            style: AppTextStyles.bodyMedium.copyWith(color: ColorTokens.red),
            textAlign: TextAlign.center,
          ),
          if (buttonText != null && onRetry != null) ...[
            const SizedBox(height: 16),
            CustomTextButton.secondary(
              onPressed: onRetry!,
              content: buttonText!,
            ),
          ],
        ],
      ),
    );
  }
}
