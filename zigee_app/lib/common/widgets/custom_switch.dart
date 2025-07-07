import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;

  const CustomSwitch({
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
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: ColorTokens.gray900,
          inactiveThumbColor: ColorTokens.gray400,
          inactiveTrackColor: ColorTokens.gray200,
          trackOutlineColor: const WidgetStatePropertyAll(
            ColorTokens.borderPrimary,
          ),
          splashRadius: 0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        if (label != null) ...[
          const SizedBox(width: 8),
          Text(label!, style: const TextStyle(color: ColorTokens.textPrimary)),
        ],
      ],
    );
  }
}
