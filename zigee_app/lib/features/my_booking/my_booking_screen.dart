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
import 'package:zigee_app/features/my_booking/widgets/my_booking_room_card.dart';

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
                  MyBookingRoomCard(),
                  MyBookingRoomCard(),
                  MyBookingRoomCard(),
                  MyBookingRoomCard(),
                ],
              ),
              ExpansionTile(
                title: Text('완료된 예약 목록', style: TypographyStyles.titleMedium),
                children: [Opacity(opacity: 0.5, child: MyBookingRoomCard())],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
