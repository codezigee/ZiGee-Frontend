import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/app/theme/typography_tokens.dart';
import 'package:zigee_app/common/widgets/custom_text_button.dart';
import 'package:zigee_app/common/widgets/network_image_widget.dart';
import 'package:zigee_app/features/my_booking/widgets/my_booking_detail_dialog.dart';
import 'package:zigee_app/models/reservation.dart';
import 'package:zigee_app/models/room.dart';

class MyBookingRoomCard extends StatelessWidget {
  final Room room;
  final Reservation reservation;

  const MyBookingRoomCard({
    super.key,
    required this.room,
    required this.reservation,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final isExpired = reservation.endTime.isBefore(DateTime.now());

    Widget card = Container(
      margin: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.bookingCardHorizontalPadding,
        vertical: SpacingTokens.bookingCardVerticalPadding,
      ),
      width: mediaQuery.width,
      height: SizingTokens.bookingCardHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: SizingTokens.bookingCardImageSize,
            child: NetworkImageWidget(
              imageUrl: room.imageUrl,
              width: SizingTokens.bookingCardImageSize,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: SpacingTokens.md),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room.name,
                  style: TypographyStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${reservation.timeUntilStart} (${reservation.formattedDateTime})',
                  style: TypographyStyles.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (isExpired) {
      return Opacity(opacity: 0.5, child: card);
    } else {
      return InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder:
                (_) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(SizingTokens.radiusXxl),
                  ),
                  child: MyBookingDetailDialog(
                    room: room,
                    reservation: reservation,
                    onCloseButtonPressed: () => context.pop(),
                    onCancelButtonPressed: () => context.pop(),
                    onChangeButtonPressed: () => context.pop(),
                  ),
                ),
          );
        },
        child: card,
      );
    }
  }
}
