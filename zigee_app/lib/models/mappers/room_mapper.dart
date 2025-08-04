import 'package:zigee_app/models/dto/room_dto.dart';
import 'package:zigee_app/models/room.dart';

class RoomMapper {
  static Room fromDto(RoomDto dto) {
    return Room(
      id: dto.id,
      name: dto.name,
      capacity: dto.capacity,
      location: dto.location,
      description: dto.description,
      isAvailable: dto.isAvailable,
      imageUrl: dto.imageUrl,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  static RoomDto toDto(Room entity) {
    return RoomDto(
      id: entity.id,
      name: entity.name,
      capacity: entity.capacity,
      location: entity.location,
      description: entity.description,
      isAvailable: entity.isAvailable,
      imageUrl: entity.imageUrl,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  static List<Room> fromDtoList(List<RoomDto> dtos) {
    return dtos.map(fromDto).toList();
  }

  static List<RoomDto> toDtoList(List<Room> entities) {
    return entities.map(toDto).toList();
  }
}
