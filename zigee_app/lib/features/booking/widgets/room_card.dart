import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/common/styles/card_styles.dart';
import 'package:zigee_app/features/booking/widgets/room_available_status_badge.dart';
import 'package:zigee_app/features/booking/widgets/room_description_item.dart';
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
      decoration: CardStyles.roomCardDecoration(isSelected),
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
                            RoomDescriptionItem(
                              icon: Icons.location_on,
                              content: room.location,
                            ),
                            const SizedBox(width: SpacingTokens.sm),
                            RoomDescriptionItem(
                              icon: Icons.people,
                              content: '${room.capacity}명',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  RoomAvailableStatusBadge(room: room),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
