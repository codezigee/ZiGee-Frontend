import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/typography_tokens.dart';

class TypographyStyles {
  TypographyStyles._();

  /// 1. Display
  static const TextStyle displayLarge = TextStyle(
    fontFamily: TypographyTokens.fontFamily,
    fontSize: TypographyTokens.displayLarge,
    fontWeight: TypographyTokens.bold,
    height: TypographyTokens.lineHeightTight,
    letterSpacing: TypographyTokens.letterSpacingTight,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: TypographyTokens.fontFamily,
    fontSize: TypographyTokens.displayMedium,
    fontWeight: TypographyTokens.semiBold,
    height: TypographyTokens.lineHeightTight,
    letterSpacing: TypographyTokens.letterSpacingNone,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: TypographyTokens.fontFamily,
    fontSize: TypographyTokens.displaySmall,
    fontWeight: TypographyTokens.semiBold,
    height: TypographyTokens.lineHeightTight,
    letterSpacing: TypographyTokens.letterSpacingNone,
  );

  /// 2. Headline
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: TypographyTokens.fontFamily,
    fontSize: TypographyTokens.headlineLarge,
    fontWeight: TypographyTokens.semiBold,
    height: TypographyTokens.lineHeightTight,
    letterSpacing: TypographyTokens.letterSpacingNone,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: TypographyTokens.fontFamily,
    fontSize: TypographyTokens.headlineMedium,
    fontWeight: TypographyTokens.medium,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: TypographyTokens.fontFamily,
    fontSize: TypographyTokens.headlineSmall,
    fontWeight: TypographyTokens.medium,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
  );

  /// 3. Title
  static const TextStyle titleLarge = TextStyle(
    fontFamily: TypographyTokens.fontFamily,
    fontSize: TypographyTokens.titleLarge,
    fontWeight: TypographyTokens.medium,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: TypographyTokens.fontFamily,
    fontSize: TypographyTokens.titleMedium,
    fontWeight: TypographyTokens.medium,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: TypographyTokens.fontFamily,
    fontSize: TypographyTokens.titleSmall,
    fontWeight: TypographyTokens.medium,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
  );

  /// 4. Body
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: TypographyTokens.fontFamily,
    fontSize: TypographyTokens.bodyLarge,
    fontWeight: TypographyTokens.regular,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: TypographyTokens.fontFamily,
    fontSize: TypographyTokens.bodyMedium,
    fontWeight: TypographyTokens.regular,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: TypographyTokens.fontFamily,
    fontSize: TypographyTokens.bodySmall,
    fontWeight: TypographyTokens.regular,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
  );

  /// 5. Label
  static const TextStyle labelLarge = TextStyle(
    fontFamily: TypographyTokens.fontFamily,
    fontSize: TypographyTokens.labelLarge,
    fontWeight: TypographyTokens.medium,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: TypographyTokens.fontFamily,
    fontSize: TypographyTokens.labelMedium,
    fontWeight: TypographyTokens.medium,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: TypographyTokens.fontFamily,
    fontSize: TypographyTokens.labelSmall,
    fontWeight: TypographyTokens.medium,
    height: TypographyTokens.lineHeightNormal,
    letterSpacing: TypographyTokens.letterSpacingNone,
  );
}
