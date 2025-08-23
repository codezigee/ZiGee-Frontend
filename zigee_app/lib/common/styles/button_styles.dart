import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';

class AppButtonStyles {
  static ButtonStyle _baseStyle() => ButtonStyle(
    padding: WidgetStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(
        vertical: SpacingTokens.buttonVerticalPadding,
        horizontal: SpacingTokens.buttonHorizontalPadding,
      ),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizingTokens.radiusMd),
      ),
    ),
    elevation: WidgetStateProperty.all<double>(0),
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
    foregroundColor: WidgetStateProperty.all<Color>(ColorTokens.white),
    overlayColor: WidgetStateProperty.all<Color>(
      ColorTokens.buttonOverlayOpacity,
    ),
  );

  static ButtonStyle secondary() => _baseStyle().copyWith(
    backgroundColor: WidgetStateProperty.all<Color>(ColorTokens.white),
    foregroundColor: WidgetStateProperty.all<Color>(ColorTokens.textPrimary),
    overlayColor: WidgetStateProperty.all<Color>(ColorTokens.gray100),
    side: WidgetStateProperty.all<BorderSide>(
      const BorderSide(color: ColorTokens.borderPrimary, width: 1),
    ),
  );

  static ButtonStyle tertiary() => _baseStyle().copyWith(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
    foregroundColor: WidgetStateProperty.all<Color>(ColorTokens.textTertiary),
    overlayColor: WidgetStateProperty.all<Color>(ColorTokens.gray100),
    side: null,
  );

  static ButtonStyle success() => _baseStyle().copyWith(
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) {
        return ColorTokens.buttonDisabled;
      }
      if (states.contains(WidgetState.pressed)) {
        return ColorTokens.green.withAlpha((255 * 0.8).round());
      }
      return ColorTokens.green;
    }),
    foregroundColor: WidgetStateProperty.all<Color>(ColorTokens.white),
    overlayColor: WidgetStateProperty.all<Color>(
      ColorTokens.buttonOverlayOpacity,
    ),
  );

  static ButtonStyle destructive() => _baseStyle().copyWith(
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) {
        return ColorTokens.buttonDisabled;
      }
      if (states.contains(WidgetState.pressed)) {
        return ColorTokens.red.withAlpha((255 * 0.8).round());
      }
      return ColorTokens.red;
    }),
    foregroundColor: WidgetStateProperty.all<Color>(ColorTokens.white),
    overlayColor: WidgetStateProperty.all<Color>(
      ColorTokens.buttonOverlayOpacity,
    ),
  );
}
