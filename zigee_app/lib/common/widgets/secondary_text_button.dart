import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';

class SecondaryTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String content;

  const SecondaryTextButton({
    required this.onPressed,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(ColorTokens.white),
        foregroundColor: WidgetStateProperty.all<Color>(
          ColorTokens.borderSecondary,
        ),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return ColorTokens.gray100;
          }
          return null;
        }),
        side: WidgetStateProperty.all<BorderSide>(
          const BorderSide(color: ColorTokens.borderPrimary, width: 1),
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(
            vertical: SpacingTokens.buttonVertical,
            horizontal: SpacingTokens.buttonHorizontal,
          ),
        ),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder>((states) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizingTokens.radiusMd),
          );
        }),
      ),
      child: Text(
        content,
        style: TypographyStyles.bodyMedium.copyWith(
          color: ColorTokens.textTertiary,
        ),
      ),
    );
  }
}
