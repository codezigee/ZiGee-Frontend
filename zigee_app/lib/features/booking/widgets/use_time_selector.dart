import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/common/utils/time_utils.dart';
import 'package:zigee_app/common/widgets/custom_text_button.dart';

class UseTimeSelector extends StatelessWidget {
  final int? selectedDurationMinutes;
  final TimeOfDay? selectedStartTime;
  final Function(int) onDurationSelected;

  const UseTimeSelector({
    super.key,
    this.selectedDurationMinutes,
    this.selectedStartTime,
    required this.onDurationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '이용 시간을 선택하세요.',
          style: TypographyStyles.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              [30, 60, 90, 120].map((duration) {
                final isSelected = selectedDurationMinutes == duration;

                final endTime =
                    selectedStartTime == null
                        ? TimeOfDay.now()
                        : TimeUtils.calculateEndTime(
                          selectedStartTime!,
                          duration,
                        );
                final formatedEndTime =
                    selectedStartTime == null
                        ? ''
                        : '\n${TimeUtils.formatTime(endTime)}';

                return isSelected
                    ? CustomTextButton.primary(
                      label: '${duration}분${formatedEndTime}',
                      onPressed: () => onDurationSelected(duration),
                    )
                    : CustomTextButton.secondary(
                      label: '${duration}분${formatedEndTime}',
                      onPressed: () => onDurationSelected(duration),
                    );
              }).toList(),
        ),
      ],
    );
  }
}
