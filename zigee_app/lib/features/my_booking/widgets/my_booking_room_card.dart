import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/app/theme/typography_tokens.dart';
import 'package:zigee_app/common/widgets/custom_text_button.dart';
import 'package:zigee_app/features/my_booking/widgets/my_booking_detail_dialog.dart';

class MyBookingRoomCard extends StatelessWidget {
  const MyBookingRoomCard({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

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
                  onCloseButtonPressed: () => context.pop(),
                  onCancelButtonPressed: () => context.pop(),
                  onChangeButtonPressed: () => context.pop(),
                ),
              ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: mediaQuery.width,
        height: mediaQuery.height * 0.1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: mediaQuery.width * 0.2,
              child: Image.asset(
                'assets/images/trial_image_1.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1 회의실',
                    style: TypographyStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    '10분 뒤 (2025/05/26/22:00)',
                    style: TypographyStyles.titleSmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
