import 'package:zigee_app/models/dto/oauth_info_dto.dart';
import 'package:zigee_app/models/oauth_info.dart';

class OAuthInfoMapper {
  static OAuthInfo fromDto(OAuthInfoDto dto) {
    return OAuthInfo(
      id: dto.id,
      memberId: dto.memberId,
      provider: _mapProviderFromDto(dto.provider),
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  static OAuthInfoDto toDto(OAuthInfo entity) {
    return OAuthInfoDto(
      id: entity.id,
      memberId: entity.memberId,
      provider: _mapProviderToDto(entity.provider),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  static List<OAuthInfo> fromDtoList(List<OAuthInfoDto> dtos) {
    return dtos.map(fromDto).toList();
  }

  static List<OAuthInfoDto> toDtoList(List<OAuthInfo> entities) {
    return entities.map(toDto).toList();
  }

  static SocialProvider _mapProviderFromDto(String dtoProvider) {
    final formattedDtoProvider = dtoProvider.toLowerCase();
    switch (formattedDtoProvider) {
      case 'kakao':
        return SocialProvider.kakao;
      case 'google':
        return SocialProvider.google;
      case 'apple':
        return SocialProvider.apple;
      default:
        throw ArgumentError('Unknown provider: $dtoProvider');
    }
  }

  static String _mapProviderToDto(SocialProvider entityProvider) {
    switch (entityProvider) {
      case SocialProvider.kakao:
        return 'kakao';
      case SocialProvider.google:
        return 'google';
      case SocialProvider.apple:
        return 'apple';
    }
  }
}
