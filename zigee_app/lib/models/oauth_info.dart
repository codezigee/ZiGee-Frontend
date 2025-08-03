class OAuthInfo {
  final String id;
  final String memberId;
  final String provider;
  final DateTime createdAt;
  final DateTime updatedAt;

  OAuthInfo({
    required this.id,
    required this.memberId,
    required this.provider,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OAuthInfo.fromJson(Map<String, dynamic> json) {
    return OAuthInfo(
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

  @override
  bool operator ==(Object other) {
    return other is OAuthInfo && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}