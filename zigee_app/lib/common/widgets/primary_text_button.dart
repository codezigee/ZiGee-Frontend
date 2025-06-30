import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';

class PrimaryTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String content;

  const PrimaryTextButton({
    required this.onPressed,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.disabled)) {
            return ColorTokens.buttonDisabled;
          }
          if (states.contains(WidgetState.pressed)) {
            return ColorTokens.buttonPressed;
          }
          return ColorTokens.buttonPrimary;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.white70; // 비활성화 텍스트색
          }
          return ColorTokens.white;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (states) =>
              states.contains(WidgetState.pressed)
                  ? ColorTokens.buttonOverlayOpacity
                  : null,
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
          color: ColorTokens.textOnDark,
        ),
      ),
    );
  }
}
