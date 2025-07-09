import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/common/styles/text_styles.dart';
import 'package:zigee_app/common/widgets/custom_text_button.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';

class EmptyStateNotice extends StatelessWidget {
  final String message;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyStateNotice({
    required this.message,
    this.buttonText,
    this.onButtonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.list_alt_outlined,
            size: SizingTokens.iconHuge,
            color: ColorTokens.textTertiary,
          ),
          const SizedBox(height: SpacingTokens.sm),
          Text(
            message,
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (buttonText != null && onButtonPressed != null) ...[
            const SizedBox(height: SpacingTokens.md),
            CustomTextButton.secondary(
              onPressed: onButtonPressed!,
              label: buttonText!,
            ),
          ],
        ],
      ),
    );
  }
}
