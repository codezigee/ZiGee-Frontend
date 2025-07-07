import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/typography_tokens.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String? label;

  const CustomCheckbox({
    required this.value,
    required this.onChanged,
    this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: ColorTokens.gray900,
          checkColor: ColorTokens.white,
          side: const BorderSide(color: ColorTokens.borderPrimary, width: 2),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        if (label != null)
          Text(
            label!,
            style: const TextStyle(
              color: ColorTokens.textPrimary,
              fontWeight: TypographyTokens.regular,
            ),
          ),
      ],
    );
  }
}
