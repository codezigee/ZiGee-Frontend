import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/common/styles/text_styles.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final String? label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hint;

  const CustomDropdownButton({
    this.label,
    required this.value,
    required this.items,
    this.onChanged,
    this.hint,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTextStyles.bodySmall),
          const SizedBox(height: 8),
        ],
        DropdownMenu<T>(
          width: MediaQuery.of(context).size.width - 48,
          initialSelection: value,
          onSelected: onChanged,
          dropdownMenuEntries:
              items
                  .map(
                    (item) => DropdownMenuEntry<T>(
                      value: item.value!,
                      label:
                          (item.child is Text)
                              ? (item.child as Text).data ?? ''
                              : item.value.toString(),
                      style: ButtonStyle(
                        textStyle: WidgetStateProperty.resolveWith<TextStyle>((
                          states,
                        ) {
                          if (value == item.value) {
                            return AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            );
                          }
                          return AppTextStyles.bodyLarge;
                        }),
                        foregroundColor: const WidgetStatePropertyAll(
                          ColorTokens.textPrimary,
                        ),
                        backgroundColor: const WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                        overlayColor: const WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                        elevation: const WidgetStatePropertyAll(0),
                      ),
                    ),
                  )
                  .toList(),
          menuStyle: MenuStyle(
            backgroundColor: const WidgetStatePropertyAll(ColorTokens.white),
            elevation: const WidgetStatePropertyAll(0),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(SizingTokens.radiusMd),
                side: const BorderSide(
                  color: ColorTokens.borderPrimary,
                  width: 1,
                ),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: ColorTokens.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizingTokens.radiusMd),
              borderSide: const BorderSide(
                color: ColorTokens.borderPrimary,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizingTokens.radiusMd),
              borderSide: const BorderSide(
                color: ColorTokens.borderPrimary,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizingTokens.radiusMd),
              borderSide: const BorderSide(
                color: ColorTokens.borderPrimary,
                width: 2,
              ),
            ),
            isDense: true,
          ),
          hintText: hint,
        ),
      ],
    );
  }
}
