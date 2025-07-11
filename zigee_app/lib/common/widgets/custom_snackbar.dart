import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/app/theme/typography_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';

class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    final snackBar = SnackBar(
      duration: duration,
      backgroundColor: ColorTokens.buttonPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizingTokens.radiusLg),
      ),
      margin: const EdgeInsets.all(SpacingTokens.screenXs),
      behavior: SnackBarBehavior.floating,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            title,
            style: TypographyStyles.bodyLarge.copyWith(
              color: ColorTokens.textOnDark,
              fontWeight: TypographyTokens.bold,
            ),
          ),
          const SizedBox(height: SpacingTokens.xs),
          Text(
            message,
            style: TypographyStyles.bodyMedium.copyWith(
              color: ColorTokens.textOnDark,
            ),
          ),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
