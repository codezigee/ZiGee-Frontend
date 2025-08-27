import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/common/styles/button_styles.dart';
import 'package:zigee_app/common/styles/text_styles.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String assetPath;
  final Color backgroundColor;
  final VoidCallback? onPressed;
  final TextStyle textStyle;
  final ButtonStyle? buttonStyle;

  const SocialLoginButton({
    required this.text,
    required this.assetPath,
    required this.backgroundColor,
    this.onPressed,
    required this.textStyle,
    this.buttonStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style:
          buttonStyle ??
          AppButtonStyles.primary().copyWith(
            backgroundColor: WidgetStatePropertyAll(backgroundColor),
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            assetPath,
            width: SizingTokens.buttonIconSize,
            height: SizingTokens.buttonIconSize,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          Text(text, style: textStyle),
          const Spacer(),
        ],
      ),
    );
  }
}
