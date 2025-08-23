import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/app/theme/typography_tokens.dart';
import 'package:zigee_app/common/widgets/custom_text_button.dart';
import 'package:zigee_app/models/reservation.dart';
import 'package:zigee_app/models/room.dart';

class MyBookingDetailDialog extends StatelessWidget {
  final Room room;
  final Reservation reservation;
  final VoidCallback onCloseButtonPressed;
  final VoidCallback onCancelButtonPressed;
  final VoidCallback onChangeButtonPressed;

  const MyBookingDetailDialog({
    super.key,
    required this.room,
    required this.reservation,
    required this.onCloseButtonPressed,
    required this.onCancelButtonPressed,
    required this.onChangeButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: onCloseButtonPressed,
              ),
            ],
          ),
          Text(
            '예약 확인',
            style: TypographyStyles.titleLarge.copyWith(
              fontWeight: TypographyTokens.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: SpacingTokens.md),
          Row(
            children: [
              const Text(
                '장소',
                style: TypographyStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Text(
                room.name,
                style: TypographyStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: SpacingTokens.sm),
          Row(
            children: [
              const Text(
                '시간',
                style: TypographyStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Text(
                reservation.formattedDateTime,
                style: TypographyStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: SpacingTokens.md),
          OutlinedButton(
            onPressed: reservation.canBeModified() ? onChangeButtonPressed : null,
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorTokens.gray800,
              side: const BorderSide(color: ColorTokens.gray300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(SizingTokens.radiusLg),
              ),
              padding: const EdgeInsets.symmetric(vertical: SpacingTokens.md),
            ),
            child: const Text('일시 변경'),
          ),
          const SizedBox(height: SpacingTokens.sm),
          CustomTextButton.primary(
            onPressed: reservation.canBeCancelled() ? onCancelButtonPressed : null,
            label: '예약 취소',
          ),
        ],
      ),
    );
  }
}
