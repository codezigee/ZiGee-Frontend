import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/common/widgets/custom_snackbar.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onChanged;
  final String? label;

  const CustomDatePicker({
    required this.selectedDate,
    required this.onChanged,
    this.label,
    super.key,
  });

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorTokens.gray900,
              onPrimary: ColorTokens.white,
              surface: ColorTokens.white,
              onSurface: ColorTokens.textPrimary,
            ),
            dialogTheme: const DialogThemeData(
              elevation: 0,
              backgroundColor: ColorTokens.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      onChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: const TextStyle(color: ColorTokens.textPrimary)),
          const SizedBox(width: 8),
        ],
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: ColorTokens.white,
            foregroundColor: ColorTokens.textPrimary,
            side: const BorderSide(color: ColorTokens.borderPrimary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          onPressed: () => _pickDate(context),
          child: Text(
            selectedDate != null
                ? '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}'
                : '날짜 선택',
            style: const TextStyle(color: ColorTokens.textPrimary),
          ),
        ),
      ],
    );
  }
}
