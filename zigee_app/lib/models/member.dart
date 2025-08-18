class Member {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String loginType;
  final String? profileImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Member({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.loginType,
    this.profileImageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  Member copyWith({
    String? name,
    String? email,
    String? phone,
    String? profileImageUrl,
  }) {
    return Member(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      loginType: loginType,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Member && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
