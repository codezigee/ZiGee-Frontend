enum SocialProvider { kakao, google, apple }

class OAuthInfo {
  final String id;
  final String memberId;
  final SocialProvider provider;
  final DateTime createdAt;
  final DateTime updatedAt;

  OAuthInfo({
    required this.id,
    required this.memberId,
    required this.provider,
    required this.createdAt,
    required this.updatedAt,
  });

  String get providerDisplayName {
    switch (provider) {
      case SocialProvider.kakao:
        return '카카오';
      case SocialProvider.google:
        return '구글';
      case SocialProvider.apple:
        return '애플';
    }
  }

  @override
  bool operator ==(Object other) {
    return other is OAuthInfo && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
