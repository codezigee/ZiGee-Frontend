import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';

class BookingConditionCard extends StatelessWidget {
  final String formattedDate;
  final String timeRange;
  final int selectedDurationMinutes;

  const BookingConditionCard({
    super.key,
    required this.formattedDate,
    required this.timeRange,
    required this.selectedDurationMinutes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SpacingTokens.lg),
      margin: const EdgeInsets.only(
        top: SpacingTokens.lg,
        left: SpacingTokens.lg,
        right: SpacingTokens.lg,
      ),
      decoration: BoxDecoration(
        color: ColorTokens.white,
        border: Border.all(color: ColorTokens.borderSecondary, width: 1),
        borderRadius: BorderRadius.circular(SizingTokens.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '예약 조건',
            style: TypographyStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: SpacingTokens.sm),
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 16,
                color: ColorTokens.gray600,
              ),
              const SizedBox(width: SpacingTokens.xs),
              Text(formattedDate, style: TypographyStyles.bodyMedium),
            ],
          ),
          const SizedBox(height: SpacingTokens.xs),
          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 16,
                color: ColorTokens.gray600,
              ),
              const SizedBox(width: SpacingTokens.xs),
              Text(timeRange, style: TypographyStyles.bodyMedium),
              const SizedBox(width: SpacingTokens.sm),
              Text(
                '(${selectedDurationMinutes}분)',
                style: TypographyStyles.bodySmall.copyWith(
                  color: ColorTokens.gray600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
