import 'package:flutter/material.dart';
import 'package:zigee_app/common/styles/button_styles.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String content;
  final ButtonStyle style;
  final TextStyle? textStyle;

  const CustomTextButton._({
    required this.onPressed,
    required this.content,
    required this.style,
    this.textStyle,
    super.key,
  });

  factory CustomTextButton.primary({
    required VoidCallback? onPressed,
    required String content,
    Key? key,
  }) {
    return CustomTextButton._(
      onPressed: onPressed,
      content: content,
      style: AppButtonStyles.primary(),
      textStyle: TypographyStyles.bodyMedium.copyWith(
        color: ColorTokens.textOnDark,
      ),
      key: key,
    );
  }

  factory CustomTextButton.secondary({
    required VoidCallback? onPressed,
    required String content,
    Key? key,
  }) {
    return CustomTextButton._(
      onPressed: onPressed,
      content: content,
      style: AppButtonStyles.secondary(),
      textStyle: TypographyStyles.bodyMedium.copyWith(
        color: ColorTokens.textTertiary,
      ),
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: style,
      child: Text(content, style: textStyle),
    );
  }
}
