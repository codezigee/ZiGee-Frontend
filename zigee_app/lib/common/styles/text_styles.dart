import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/typography_tokens.dart';

/// Material Design 3 기반 기본 텍스트 스타일
class AppTextStyles {
  AppTextStyles._();

  static const TextStyle _baseStyle = TextStyle(
    fontFamily: TypographyTokens.fontFamily,
  );

  /// 1. Display Styles
  static final TextStyle displayLarge = _baseStyle.copyWith(
    fontSize: TypographyTokens.displayLarge,
    fontWeight: TypographyTokens.bold,
    height: TypographyTokens.lineHeightTight,
    letterSpacing: TypographyTokens.letterSpacingTight,
    color: ColorTokens.textPrimary,
  );

  static final TextStyle displayMedium = _baseStyle.copyWith(
    fontSize: TypographyTokens.displayMedium,
    fontWeight: TypographyTokens.bold,
    height: TypographyTokens.lineHeightTight,
    letterSpacing: TypographyTokens.letterSpacingTight,
    color: ColorTokens.textPrimary,
  );

  static final TextStyle displaySmall = _baseStyle.copyWith(
    fontSize: TypographyTokens.displaySmall,
    fontWeight: TypographyTokens.bold,
    height: TypographyTokens.lineHeightTight,
    letterSpacing: TypographyTokens.letterSpacingNone,
    color: ColorTokens.textPrimary,
  );

  /// 2. Headline Styles
  static final TextStyle headlineLarge = _baseStyle.copyWith(
    fontSize: TypographyTokens.headlineLarge,
    fontWeight: TypographyTokens.bold,
    height: TypographyTokens.lineHeightTight,
    letterSpacing: TypographyTokens.letterSpacingNone,
    color: ColorTokens.textPrimary,
  );

  static final TextStyle headlineMedium = _baseStyle.copyWith(
    fontSize: TypographyTokens.headlineMedium,
    fontWeight: TypographyTokens.semiBold,
    height: TypographyTokens.lineHeightTight,
    letterSpacing: TypographyTokens.letterSpacingNone,
    color: ColorTokens.textPrimary,
  );

  static final TextStyle headlineSmall = _baseStyle.copyWith(
    fontSize: TypographyTokens.headlineSmall,
    fontWeight: TypographyTokens.semiBold,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
    color: ColorTokens.textPrimary,
  );

  /// 3. Title Styles
  static final TextStyle titleLarge = _baseStyle.copyWith(
    fontSize: TypographyTokens.titleLarge,
    fontWeight: TypographyTokens.semiBold,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
    color: ColorTokens.textPrimary,
  );

  static final TextStyle titleMedium = _baseStyle.copyWith(
    fontSize: TypographyTokens.titleMedium,
    fontWeight: TypographyTokens.medium,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
    color: ColorTokens.textPrimary,
  );

  static final TextStyle titleSmall = _baseStyle.copyWith(
    fontSize: TypographyTokens.titleSmall,
    fontWeight: TypographyTokens.medium,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
    color: ColorTokens.textSecondary,
  );

  /// 4. Body Styles
  static final TextStyle bodyLarge = _baseStyle.copyWith(
    fontSize: TypographyTokens.bodyLarge,
    fontWeight: TypographyTokens.regular,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
    color: ColorTokens.textSecondary,
  );

  static final TextStyle bodyMedium = _baseStyle.copyWith(
    fontSize: TypographyTokens.bodyMedium,
    fontWeight: TypographyTokens.regular,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
    color: ColorTokens.textSecondary,
  );

  static final TextStyle bodySmall = _baseStyle.copyWith(
    fontSize: TypographyTokens.bodySmall,
    fontWeight: TypographyTokens.regular,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
    color: ColorTokens.textTertiary,
  );

  /// 5. Label Styles
  static final TextStyle labelLarge = _baseStyle.copyWith(
    fontSize: TypographyTokens.labelLarge,
    fontWeight: TypographyTokens.medium,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
    color: ColorTokens.textSecondary,
  );

  static final TextStyle labelMedium = _baseStyle.copyWith(
    fontSize: TypographyTokens.labelMedium,
    fontWeight: TypographyTokens.medium,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
    color: ColorTokens.textTertiary,
  );

  static final TextStyle labelSmall = _baseStyle.copyWith(
    fontSize: TypographyTokens.labelSmall,
    fontWeight: TypographyTokens.medium,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingWide,
    color: ColorTokens.textPlaceholder,
  );
}
