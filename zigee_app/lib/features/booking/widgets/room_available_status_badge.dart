import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/models/room.dart';

class RoomAvailableStatusBadge extends StatelessWidget {
  final Room room;

  const RoomAvailableStatusBadge({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.sm,
        vertical: SpacingTokens.xs,
      ),
      decoration: BoxDecoration(
        color:
            room.isAvailable
                ? ColorTokens.statusSuccess.withValues(alpha: 0.1)
                : ColorTokens.statusError.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        room.isAvailable ? '예약 가능' : '예약 불가',
        style: TypographyStyles.bodySmall.copyWith(
          color:
              room.isAvailable
                  ? ColorTokens.statusSuccess
                  : ColorTokens.statusError,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
