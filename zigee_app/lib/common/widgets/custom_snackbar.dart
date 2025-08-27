import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/app/theme/typography_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/features/auth/models/auth_result.dart';

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
      margin: const EdgeInsets.all(SpacingTokens.space16),
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

  static void showError(
    BuildContext context,
    AuthError authError, {
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      duration: duration,
      backgroundColor: ColorTokens.buttonPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizingTokens.radiusLg),
      ),
      margin: const EdgeInsets.all(SpacingTokens.space16),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.white, size: 20),
          const SizedBox(width: SpacingTokens.sm),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  authError.type.displayName,
                  style: TypographyStyles.bodyLarge.copyWith(
                    color: ColorTokens.white,
                    fontWeight: TypographyTokens.bold,
                  ),
                ),
                const SizedBox(height: SpacingTokens.xs),
                Text(
                  authError.message,
                  style: TypographyStyles.bodyMedium.copyWith(
                    color: ColorTokens.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showWarning(
    BuildContext context,
    String title,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      duration: duration,
      backgroundColor: ColorTokens.buttonPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizingTokens.radiusLg),
      ),
      margin: const EdgeInsets.all(SpacingTokens.space16),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          const Icon(
            Icons.warning_amber_outlined,
            color: ColorTokens.white,
            size: 20,
          ),
          const SizedBox(width: SpacingTokens.sm),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TypographyStyles.bodyLarge.copyWith(
                    color: ColorTokens.white,
                    fontWeight: TypographyTokens.bold,
                  ),
                ),
                const SizedBox(height: SpacingTokens.xs),
                Text(
                  message,
                  style: TypographyStyles.bodyMedium.copyWith(
                    color: ColorTokens.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
