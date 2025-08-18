import 'package:zigee_app/models/dto/member_dto.dart';
import 'package:zigee_app/models/member.dart';

class MemberMapper {
  static Member fromDto(MemberDto dto) {
    return Member(
      id: dto.id,
      name: dto.name,
      email: dto.email,
      phone: dto.phone,
      loginType: dto.loginType ?? 'email',
      profileImageUrl: dto.profileImageUrl,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  static MemberDto toDto(Member entity) {
    return MemberDto(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      password: null,
      phone: entity.phone,
      loginType: entity.loginType,
      profileImageUrl: entity.profileImageUrl,
      role: 'user',
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  static List<Member> fromDtoList(List<MemberDto> dtos) {
    return dtos.map(fromDto).toList();
  }

  static List<MemberDto> toDtoList(List<Member> entities) {
    return entities.map(toDto).toList();
  }
}
