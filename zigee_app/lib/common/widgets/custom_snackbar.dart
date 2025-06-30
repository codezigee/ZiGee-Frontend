import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';

class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    Get.showSnackbar(
      GetSnackBar(
        titleText: Text(
          title,
          style: TypographyStyles.bodyLarge.copyWith(
            color: ColorTokens.textOnDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text(
          title,
          style: TypographyStyles.bodyMedium.copyWith(
            color: ColorTokens.textOnDark,
          ),
        ),
        backgroundColor: ColorTokens.buttonPrimary,
        borderRadius: 12,
        margin: const EdgeInsets.all(SpacingTokens.screenXs),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
