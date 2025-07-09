import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/common/styles/button_styles.dart';

class SecondaryTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String content;

  const SecondaryTextButton({
    required this.onPressed,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: AppButtonStyles.secondary(),
      child: Text(
        content,
        style: TypographyStyles.bodyMedium.copyWith(
          color: ColorTokens.textTertiary,
        ),
      ),
    );
  }
}
