import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';

class AppButtonStyles {
  static ButtonStyle _baseStyle() => ButtonStyle(
    padding: WidgetStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(
        vertical: SpacingTokens.buttonVertical,
        horizontal: SpacingTokens.buttonHorizontal,
      ),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizingTokens.radiusMd),
      ),
    ),
  );

  static ButtonStyle primary() => _baseStyle().copyWith(
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
        return ColorTokens.white.withAlpha(179);
      }
      return ColorTokens.white;
    }),
    overlayColor: WidgetStateProperty.resolveWith<Color?>(
      (states) =>
          states.contains(WidgetState.pressed)
              ? ColorTokens.buttonOverlayOpacity
              : null,
    ),
  );

  static ButtonStyle secondary() => _baseStyle().copyWith(
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
  );
}
