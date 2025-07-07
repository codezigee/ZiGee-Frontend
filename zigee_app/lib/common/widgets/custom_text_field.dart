import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/app/theme/typography_tokens.dart';
import 'package:zigee_app/common/styles/text_styles.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final TextEditingController? controller;

  const CustomTextField({
    this.labelText,
    this.onChanged,
    this.obscureText = false,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      style: const TextStyle(color: ColorTokens.textPrimary),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TypographyStyles.bodyMedium,
        floatingLabelStyle: TypographyStyles.labelLarge,
        contentPadding: const EdgeInsets.symmetric(
          vertical: SpacingTokens.sm,
          horizontal: SpacingTokens.md,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(SizingTokens.radiusMd),
          ),
          borderSide: BorderSide(color: ColorTokens.borderPrimary, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(SizingTokens.radiusMd),
          ),
          borderSide: BorderSide(color: ColorTokens.borderFocus, width: 2),
        ),
      ),
    );
  }
}
