import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/app/theme/typography_styles.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class DaySelector extends StatelessWidget {
  final DateTime focusedDay;
  final bool Function(DateTime) selectedDayPredicate;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(DateTime) onPageChanged;

  const DaySelector({
    super.key,
    required this.focusedDay,
    required this.selectedDayPredicate,
    required this.onDaySelected,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '날짜를 선택하세요.',
          style: TypographyStyles.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        TableCalendar(
          focusedDay: focusedDay,
          firstDay: kFirstDay,
          lastDay: kLastDay,
          selectedDayPredicate: selectedDayPredicate,
          onDaySelected: onDaySelected,
          onPageChanged: onPageChanged,
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
      ],
    );
  }
}
