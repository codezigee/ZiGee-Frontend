import 'package:flutter/material.dart';
import 'package:zigee_app/common/styles/button_styles.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final ButtonStyle style;
  final TextStyle? textStyle;

  const CustomTextButton._({
    this.onPressed,
    required this.label,
    required this.style,
    this.textStyle,
    super.key,
  });

  factory CustomTextButton.primary({
    VoidCallback? onPressed,
    required String label,
    Key? key,
  }) {
    return CustomTextButton._(
      onPressed: onPressed,
      label: label,
      style: AppButtonStyles.primary(),
      textStyle: TypographyStyles.bodyMedium.copyWith(color: ColorTokens.white),
      key: key,
    );
  }

  factory CustomTextButton.secondary({
    VoidCallback? onPressed,
    required String label,
    Key? key,
  }) {
    return CustomTextButton._(
      onPressed: onPressed,
      label: label,
      style: AppButtonStyles.secondary(),
      textStyle: TypographyStyles.bodyMedium.copyWith(
        color: ColorTokens.textPrimary,
      ),
      key: key,
    );
  }

  factory CustomTextButton.tertiary({
    VoidCallback? onPressed,
    required String label,
    Key? key,
  }) {
    return CustomTextButton._(
      onPressed: onPressed,
      label: label,
      style: AppButtonStyles.tertiary(),
      textStyle: TypographyStyles.bodyMedium.copyWith(
        color: ColorTokens.textTertiary,
      ),
      key: key,
    );
  }

  factory CustomTextButton.success({
    VoidCallback? onPressed,
    required String label,
    Key? key,
  }) {
    return CustomTextButton._(
      onPressed: onPressed,
      label: label,
      style: AppButtonStyles.success(),
      textStyle: TypographyStyles.bodyMedium.copyWith(color: ColorTokens.white),
      key: key,
    );
  }

  factory CustomTextButton.destructive({
    VoidCallback? onPressed,
    required String label,
    Key? key,
  }) {
    return CustomTextButton._(
      onPressed: onPressed,
      label: label,
      style: AppButtonStyles.destructive(),
      textStyle: TypographyStyles.bodyMedium.copyWith(color: ColorTokens.white),
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: style,
      child: Text(label, style: textStyle, textAlign: TextAlign.center),
    );
  }
}
