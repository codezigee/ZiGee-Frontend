import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/spacing_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';
import 'package:zigee_app/common/widgets/custom_date_picker.dart';
import 'package:zigee_app/common/widgets/custom_text_button.dart';
import 'package:zigee_app/features/booking/widgets/available_rooms_list.dart';
import 'package:zigee_app/models/room.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

enum TimePeriod {
  am,
  pm;

  String displayName() {
    switch (this) {
      case TimePeriod.am:
        return '오전';
      case TimePeriod.pm:
        return '오후';
    }
  }
}

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime focusedDate = DateTime.now();
  DateTime? selectedDate = DateTime.now();
  TimeOfDay? selectedStartTime;
  int? selectedDurationMinutes;

  List<Room> get _sampleRooms => [
    Room(
      id: '1',
      name: '회의실 A',
      capacity: 8,
      location: '2층',
      description: '프로젝터, 화이트보드 구비',
      isAvailable: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Room(
      id: '2',
      name: '회의실 B',
      capacity: 12,
      location: '3층',
      description: '대형 회의실, 화상회의 시설 완비',
      isAvailable: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Room(
      id: '3',
      name: '소회의실 C',
      capacity: 4,
      location: '2층',
      description: '소규모 미팅용',
      isAvailable: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  List<TimeOfDay> get _availableStartTimes {
    final times = <TimeOfDay>[];
    for (int hour = 9; hour <= 22; hour++) {
      times.add(TimeOfDay(hour: hour, minute: 0));
    }
    return times;
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  TimeOfDay _calculateEndTime(TimeOfDay startTime, int durationMinutes) {
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = startMinutes + durationMinutes;
    final endHour = (endMinutes ~/ 60) % 24;
    final endMinute = endMinutes % 60;
    return TimeOfDay(hour: endHour, minute: endMinute);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final scrollController = ScrollController();

    return Scaffold(
      appBar: const CupertinoNavigationBar(
        leading: Text('예약하기', style: TypographyStyles.titleLarge),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: SpacingTokens.md,
            horizontal: SpacingTokens.lg,
          ),
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    _searchAvailableRooms();
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
                    _availableStartTimes.map((time) {
                      final isSelected = selectedStartTime == time;
                      final formatedTime = _formatTime(time);

                      onStartTimeSelected(time) {
                        setState(() {
                          selectedStartTime = time;
                        });
                        _searchAvailableRooms();
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
                              : _calculateEndTime(selectedStartTime!, duration);
                      final formatedEndTime =
                          selectedStartTime == null
                              ? ''
                              : '\n${_formatTime(endTime)}';

                      onDurationSelected(duration) {
                        setState(() {
                          selectedDurationMinutes = duration;
                        });
                        _searchAvailableRooms();
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
                    label: '조회',
                    onPressed: () {
                      debugPrint('Clicked 조회 Button');
                    },
                  )
                  : CustomTextButton.destructive(label: '조회'),
            ],
          ),
        ),
      ),
    );
  }
}
