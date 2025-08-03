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

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'] as String,
      uid: json['uid'] as String,
      userId: json['user_id'] as String,
      roomId: json['room_id'] as String,
      title: json['title'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      purpose: json['purpose'] as String?,
      status: _parseStatus(json['status'] as String?),
      attendeeCount: json['attendee_count'] ?? 1,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  static ReservationStatus _parseStatus(String? status) {
    switch (status?.toUpperCase()) {
      case 'CONFIRMED':
        return ReservationStatus.confirmed;
      case 'CANCELLED':
        return ReservationStatus.cancelled;
      case 'PENDING':
      default:
        return ReservationStatus.pending;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'user_id': userId,
      'room_id': roomId,
      'title': title,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'purpose': purpose,
      'status': status.name.toUpperCase(),
      'attendee_count': attendeeCount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    return other is Reservation && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}