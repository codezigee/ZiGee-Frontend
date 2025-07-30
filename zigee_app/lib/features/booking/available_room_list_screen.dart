import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zigee_app/app/mock/mock_room_data.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/size_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/common/utils/time_utils.dart';
import 'package:zigee_app/common/widgets/custom_dialog.dart';
import 'package:zigee_app/common/widgets/custom_snackbar.dart';
import 'package:zigee_app/common/widgets/custom_text_button.dart';
import 'package:zigee_app/features/booking/widgets/booking_condition_card.dart';
import 'package:zigee_app/features/booking/widgets/room_card.dart';
import 'package:zigee_app/features/booking/widgets/room_card_list.dart';
import 'package:zigee_app/models/room.dart';

class AvailableRoomListScreen extends StatefulWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedStartTime;
  final int selectedDurationMinutes;

  const AvailableRoomListScreen({
    super.key,
    required this.selectedDate,
    required this.selectedStartTime,
    required this.selectedDurationMinutes,
  });

  @override
  State<AvailableRoomListScreen> createState() =>
      _AvailableRoomListScreenState();
}

class _AvailableRoomListScreenState extends State<AvailableRoomListScreen> {
  Room? _selectedRoom;

  @override
  Widget build(BuildContext context) {
    final endTime = TimeUtils.calculateEndTime(
      widget.selectedStartTime,
      widget.selectedDurationMinutes,
    );
    final formattedDate =
        '${widget.selectedDate.year}년 ${widget.selectedDate.month}월 ${widget.selectedDate.day}일';
    final timeRange =
        '${TimeUtils.formatTime(widget.selectedStartTime)} - ${TimeUtils.formatTime(endTime)}';

    return Scaffold(
      appBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        middle: const Text('회의실 선택', style: TypographyStyles.titleLarge),
      ),
      body: SafeArea(
        child: Column(
          children: [
            BookingConditionCard(
              formattedDate: formattedDate,
              timeRange: timeRange,
              selectedDurationMinutes: widget.selectedDurationMinutes,
            ),

            RoomCardList(rooms: MockRoomData.rooms),
          ],
        ),
      ),
    );
  }
}
