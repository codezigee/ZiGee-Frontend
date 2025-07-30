import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/common/utils/time_utils.dart';
import 'package:zigee_app/common/widgets/custom_date_picker.dart';
import 'package:zigee_app/common/widgets/custom_text_button.dart';
import 'package:zigee_app/features/booking/widgets/day_selector.dart';
import 'package:zigee_app/features/booking/widgets/start_time_selector.dart';
import 'package:zigee_app/features/booking/widgets/use_time_selector.dart';
import 'package:zigee_app/models/room.dart';
import 'package:zigee_app/app/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class RoomSearchScreen extends StatefulWidget {
  const RoomSearchScreen({super.key});

  @override
  State<RoomSearchScreen> createState() => _RoomSearchScreenState();
}

class _RoomSearchScreenState extends State<RoomSearchScreen> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDate = DateTime.now();
  TimeOfDay? selectedStartTime;
  int? selectedDurationMinutes;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final scrollController = ScrollController();

    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('회의실 조회', style: TypographyStyles.titleLarge),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: SpacingTokens.md,
            horizontal: SpacingTokens.lg,
          ),
          physics: const ClampingScrollPhysics(),

          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: SpacingTokens.sm,
            children: [
              /// 1. 날짜 선택
              DaySelector(
                focusedDay: focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(selectedDate, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(selectedDate, selectedDay)) {
                    setState(() {
                      selectedDate = selectedDay;
                      focusedDay = focusedDay;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  focusedDay = focusedDay;
                },
              ),
              const SizedBox(height: SpacingTokens.md),

              /// 2. 시간 선택
              StartTimeSelector(
                selectedStartTime: selectedStartTime,
                onStartTimeSelected: (time) {
                  setState(() {
                    selectedStartTime = time;
                  });
                },
              ),
              const SizedBox(height: SpacingTokens.md),

              /// 3. 시간 선택
              UseTimeSelector(
                onDurationSelected: (duration) {
                  setState(() {
                    selectedDurationMinutes = duration;
                  });
                },
              ),
              const SizedBox(height: SpacingTokens.md),

              selectedDate != null &&
                      selectedStartTime != null &&
                      selectedDurationMinutes != null
                  ? CustomTextButton.primary(
                    label: '조회하기',
                    onPressed: () {
                      context.push(
                        AppRoutes.roomList,
                        extra: {
                          'selectedDate': selectedDate,
                          'selectedStartTime': selectedStartTime,
                          'selectedDurationMinutes': selectedDurationMinutes,
                        },
                      );
                    },
                  )
                  : CustomTextButton.destructive(label: '조회하기'),
            ],
          ),
        ),
      ),
    );
  }
}
