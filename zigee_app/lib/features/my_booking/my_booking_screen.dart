import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/app/theme/typography_tokens.dart';
import 'package:zigee_app/common/widgets/custom_dialog.dart';
import 'package:zigee_app/common/widgets/custom_text_button.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final scrollController = ScrollController();

    return Scaffold(
      appBar: const CupertinoNavigationBar(
        leading: Text('내 예약 현황', style: TypographyStyles.titleLarge),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: const Column(
            children: [
              ExpansionTile(
                title: Text(
                  '현재 진행 중인/예정 예약 목록',
                  style: TypographyStyles.titleMedium,
                ),
                initiallyExpanded: true,
                collapsedBackgroundColor: Colors.transparent,
                shape: null,
                children: [
                  BookingRoomCard(),
                  BookingRoomCard(),
                  BookingRoomCard(),
                  BookingRoomCard(),
                ],
              ),
              ExpansionTile(
                title: Text('완료된 예약 목록', style: TypographyStyles.titleMedium),
                children: [Opacity(opacity: 0.5, child: BookingRoomCard())],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingRoomCard extends StatelessWidget {
  const BookingRoomCard({super.key});

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
                child: Padding(
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
                            onPressed: () => context.pop(),
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
                      const Row(
                        children: [
                          Text(
                            '장소',
                            style: TypographyStyles.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          Text(
                            '1 회의실',
                            style: TypographyStyles.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: SpacingTokens.sm),
                      const Row(
                        children: [
                          Text(
                            '시간',
                            style: TypographyStyles.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          Text(
                            '2025/05/26/22:00',
                            style: TypographyStyles.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: SpacingTokens.md),
                      OutlinedButton(
                        onPressed: context.pop,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: ColorTokens.gray800,
                          side: const BorderSide(color: ColorTokens.gray300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              SizingTokens.radiusLg,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: SpacingTokens.md,
                          ),
                        ),
                        child: const Text('일시 변경'),
                      ),
                      const SizedBox(height: SpacingTokens.sm),
                      CustomTextButton.primary(
                        onPressed: context.pop,
                        label: '예약 취소',
                      ),
                    ],
                  ),
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
