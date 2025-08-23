class OAuthInfoDto {
  final String id;
  final String memberId;
  final String provider;
  final DateTime createdAt;
  final DateTime updatedAt;

  OAuthInfoDto({
    required this.id,
    required this.memberId,
    required this.provider,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OAuthInfoDto.fromJson(Map<String, dynamic> json) {
    return OAuthInfoDto(
      id: json['id'] as String,
      memberId: json['member_id'] as String,
      provider: json['provider'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'member_id': memberId,
      'provider': provider,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}