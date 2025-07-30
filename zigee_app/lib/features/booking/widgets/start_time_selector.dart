import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/common/utils/time_utils.dart';
import 'package:zigee_app/common/widgets/custom_text_button.dart';

class StartTimeSelector extends StatelessWidget {
  final TimeOfDay? selectedStartTime;
  final Function(TimeOfDay) onStartTimeSelected;

  const StartTimeSelector({
    super.key,
    this.selectedStartTime,
    required this.onStartTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: SpacingTokens.sm,
      children: [
        Text(
          '시작 시간을 선택하세요.',
          style: TypographyStyles.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Wrap(
          spacing: SpacingTokens.sm,
          runSpacing: SpacingTokens.sm,
          children:
              TimeUtils.getAvailableStartTimes.map((time) {
                final isSelected = selectedStartTime == time;
                final formatedTime = TimeUtils.formatTime(time);

                return isSelected
                    ? CustomTextButton.primary(
                      label: formatedTime,
                      onPressed: () => onStartTimeSelected(time),
                    )
                    : CustomTextButton.secondary(
                      label: formatedTime,
                      onPressed: () => onStartTimeSelected(time),
                    );
              }).toList(),
        ),
      ],
    );
  }
}
