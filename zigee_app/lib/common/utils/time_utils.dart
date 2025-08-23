import 'package:flutter/material.dart';

class TimeUtils {
  static List<TimeOfDay> get getAvailableStartTimes {
    final times = <TimeOfDay>[];
    for (int hour = 9; hour <= 22; hour++) {
      times.add(TimeOfDay(hour: hour, minute: 0));
    }
    return times;
  }

  static String formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  static TimeOfDay calculateEndTime(TimeOfDay startTime, int durationMinutes) {
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = startMinutes + durationMinutes;
    final endHour = (endMinutes ~/ 60) % 24;
    final endMinute = endMinutes % 60;
    return TimeOfDay(hour: endHour, minute: endMinute);
  }
}
