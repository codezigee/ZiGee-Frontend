import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
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
        color: _getStatusColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(SizingTokens.radiusXl),
      ),
      child: Text(
        room.isAvailable ? '예약 가능' : '예약 불가',
        style: TypographyStyles.bodySmall.copyWith(
          color: _getStatusColor(),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getStatusColor() {
    return room.isAvailable
        ? ColorTokens.statusSuccess
        : ColorTokens.statusError;
  }
}
