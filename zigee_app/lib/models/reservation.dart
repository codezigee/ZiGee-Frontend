enum ReservationStatus { pending, confirmed, cancelled }

class Reservation {
  final String id;
  final String uid;
  final String userId;
  final String roomId;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String? purpose;
  final ReservationStatus status;
  final int attendeeCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Reservation({
    required this.id,
    required this.uid,
    required this.userId,
    required this.roomId,
    required this.title,
    required this.startTime,
    required this.endTime,
    this.purpose,
    this.status = ReservationStatus.pending,
    this.attendeeCount = 1,
    required this.createdAt,
    required this.updatedAt,
  });

  Duration get duration => endTime.difference(startTime);

  bool get isConfirmed => status == ReservationStatus.confirmed;
  bool get isPending => status == ReservationStatus.pending;
  bool get isCancelled => status == ReservationStatus.cancelled;

  bool get isToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final reservationDate = DateTime(
      startTime.year,
      startTime.month,
      startTime.day,
    );
    return reservationDate == today;
  }

  bool get isUpcoming => startTime.isAfter(DateTime.now());
  bool get isOngoing {
    final now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime) && isConfirmed;
  }

  bool get isPast => endTime.isBefore(DateTime.now());

  bool get isCompleted => isPast && (isConfirmed || isCancelled);
  bool get isActive => isConfirmed || isPending;
  bool get isScheduled => isUpcoming && (isConfirmed || isPending);

  String get formattedDateTime =>
      '${startTime.year}/${startTime.month.toString().padLeft(2, '0')}/'
      '${startTime.day.toString().padLeft(2, '0')}/'
      '${startTime.hour.toString().padLeft(2, '0')}:'
      '${startTime.minute.toString().padLeft(2, '0')}';

  String get formattedDate =>
      '${startTime.year}/${startTime.month.toString().padLeft(2, '0')}/'
      '${startTime.day.toString().padLeft(2, '0')}';

  String get displayTimeRange {
    final startStr =
        '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
    final endStr =
        '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
    return '$startStr - $endStr';
  }

  String get timeUntilStart {
    if (isPast) return '완료됨';
    if (isOngoing) return '진행중';

    final duration = startTime.difference(DateTime.now());
    if (duration.inMinutes < 60) {
      return '${duration.inMinutes}분 뒤';
    } else if (duration.inHours < 24) {
      return '${duration.inHours}시간 뒤';
    } else {
      return '${duration.inDays}일 뒤';
    }
  }

  bool canBeCancelled() {
    return (isPending || isConfirmed) && isUpcoming;
  }

  bool canBeModified() {
    return isPending && isUpcoming;
  }

  Reservation copyWith({
    String? title,
    DateTime? startTime,
    DateTime? endTime,
    String? purpose,
    ReservationStatus? status,
    int? attendeeCount,
  }) {
    return Reservation(
      id: id,
      uid: uid,
      userId: userId,
      roomId: roomId,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      purpose: purpose ?? this.purpose,
      status: status ?? this.status,
      attendeeCount: attendeeCount ?? this.attendeeCount,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Reservation && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
