import 'package:zigee_app/models/dto/reservation_dto.dart';
import 'package:zigee_app/models/reservation.dart';

class ReservationMapper {
  static Reservation fromDto(ReservationDto dto) {
    return Reservation(
      id: dto.id,
      uid: dto.uid,
      userId: dto.userId,
      roomId: dto.roomId,
      title: dto.title,
      startTime: dto.startTime,
      endTime: dto.endTime,
      purpose: dto.purpose,
      status: _mapStatusFromDto(dto.status),
      attendeeCount: dto.attendeeCount,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  static ReservationDto toDto(Reservation entity) {
    return ReservationDto(
      id: entity.id,
      uid: entity.uid,
      userId: entity.userId,
      roomId: entity.roomId,
      title: entity.title,
      startTime: entity.startTime,
      endTime: entity.endTime,
      purpose: entity.purpose,
      status: _mapStatusToDto(entity.status),
      attendeeCount: entity.attendeeCount,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  static List<Reservation> fromDtoList(List<ReservationDto> dtos) {
    return dtos.map(fromDto).toList();
  }

  static List<ReservationDto> toDtoList(List<Reservation> entities) {
    return entities.map(toDto).toList();
  }

  static ReservationStatus _mapStatusFromDto(ReservationStatusDto dtoStatus) {
    switch (dtoStatus) {
      case ReservationStatusDto.pending:
        return ReservationStatus.pending;
      case ReservationStatusDto.confirmed:
        return ReservationStatus.confirmed;
      case ReservationStatusDto.cancelled:
        return ReservationStatus.cancelled;
    }
  }

  static ReservationStatusDto _mapStatusToDto(ReservationStatus entityStatus) {
    switch (entityStatus) {
      case ReservationStatus.pending:
        return ReservationStatusDto.pending;
      case ReservationStatus.confirmed:
        return ReservationStatusDto.confirmed;
      case ReservationStatus.cancelled:
        return ReservationStatusDto.cancelled;
    }
  }
}
