import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/common/styles/button_styles.dart';

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
      style: AppButtonStyles.primary(),
      child: Text(
        content,
        style: TypographyStyles.bodyMedium.copyWith(
          color: ColorTokens.textOnDark,
        ),
      ),
    );
  }
}
