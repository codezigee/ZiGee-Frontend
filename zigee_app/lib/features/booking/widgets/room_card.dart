import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/models/room.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  final bool isSelected;
  final VoidCallback? onTap;

  const RoomCard({
    super.key,
    required this.room,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorTokens.white,
        borderRadius: BorderRadius.circular(SizingTokens.radiusMd),
        border: Border.all(
          color:
              isSelected ? ColorTokens.borderFocus : ColorTokens.borderPrimary,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(SpacingTokens.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          room.name,
                          style: TypographyStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: SpacingTokens.xs),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 14,
                              color: ColorTokens.gray600,
                            ),
                            const SizedBox(width: SpacingTokens.xs),
                            Text(
                              room.location,
                              style: TypographyStyles.bodySmall.copyWith(
                                color: ColorTokens.gray600,
                              ),
                            ),
                            const SizedBox(width: SpacingTokens.sm),
                            const Icon(
                              Icons.people,
                              size: 14,
                              color: ColorTokens.gray600,
                            ),
                            const SizedBox(width: SpacingTokens.xs),
                            Text(
                              '${room.capacity}명',
                              style: TypographyStyles.bodySmall.copyWith(
                                color: ColorTokens.gray600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
