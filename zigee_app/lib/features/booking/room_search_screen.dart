import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/common/utils/time_utils.dart';
import 'package:zigee_app/common/widgets/custom_date_picker.dart';
import 'package:zigee_app/common/widgets/custom_text_button.dart';
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
  DateTime focusedDate = DateTime.now();
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
              Text(
                '날짜를 선택하세요.',
                style: TypographyStyles.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TableCalendar(
                focusedDay: focusedDate,
                firstDay: kFirstDay,
                lastDay: kLastDay,
                selectedDayPredicate: (day) {
                  return isSameDay(selectedDate, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(selectedDate, selectedDay)) {
                    setState(() {
                      selectedDate = selectedDay;
                      focusedDate = focusedDay;
                    });

                    debugPrint('onDaySelected: $selectedDate');
                  }
                },
                onPageChanged: (focusedDay) {
                  focusedDate = focusedDay;
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorTokens.buttonDisabled,
                  ),
                  todayTextStyle: TypographyStyles.bodyMedium,
                  selectedDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorTokens.buttonPrimary,
                  ),
                  selectedTextStyle: TypographyStyles.bodyMedium.copyWith(
                    color: ColorTokens.textOnDark,
                  ),
                  defaultTextStyle: TypographyStyles.bodyMedium,
                  weekendTextStyle: TypographyStyles.bodyMedium,
                  tablePadding: EdgeInsets.zero,
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TypographyStyles.titleMedium,
                  titleTextFormatter: (dateTime, locale) {
                    return '${dateTime.year}년 ${dateTime.month}월 ${dateTime.day}일';
                  },
                  headerPadding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(height: SpacingTokens.md),

              /// 2. 시간 선택
              Text(
                '시작 시간을 선택하세요.',
                style: TypographyStyles.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Wrap(
                spacing: SpacingTokens.sm,
                runSpacing: SpacingTokens.sm,
                children:
                    TimeUtils.getAvailableStartTimes.map((time) {
                      final isSelected = selectedStartTime == time;
                      final formatedTime = TimeUtils.formatTime(time);

                      onStartTimeSelected(time) {
                        setState(() {
                          selectedStartTime = time;
                        });

                        debugPrint('onStartTimeSelected: $selectedStartTime');
                      }

                      return isSelected
                          ? CustomTextButton.primary(
                            label: formatedTime,
                            onPressed: () => onStartTimeSelected(time),
                          )
                          : CustomTextButton.secondary(
                            label: formatedTime,
                            onPressed: () => onStartTimeSelected(time),
                          );
                    }).toList(),
              ),
              const SizedBox(height: SpacingTokens.md),

              /// 3. 시간 선택
              Text(
                '이용 시간을 선택하세요.',
                style: TypographyStyles.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    [30, 60, 90, 120].map((duration) {
                      final isSelected = selectedDurationMinutes == duration;

                      final endTime =
                          selectedStartTime == null
                              ? TimeOfDay.now()
                              : TimeUtils.calculateEndTime(
                                selectedStartTime!,
                                duration,
                              );
                      final formatedEndTime =
                          selectedStartTime == null
                              ? ''
                              : '\n${TimeUtils.formatTime(endTime)}';

                      onDurationSelected(duration) {
                        setState(() {
                          selectedDurationMinutes = duration;
                        });

                        debugPrint(
                          'onDurationSelected: ${selectedDurationMinutes}',
                        );
                      }

                      return isSelected
                          ? CustomTextButton.primary(
                            label: '${duration}분${formatedEndTime}',
                            onPressed: () => onDurationSelected(duration),
                          )
                          : CustomTextButton.secondary(
                            label: '${duration}분${formatedEndTime}',
                            onPressed: () => onDurationSelected(duration),
                          );
                    }).toList(),
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
