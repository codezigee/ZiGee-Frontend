class Member {
  final String id;
  final String name;
  final String email;
  final String? password;
  final String? phone;
  final String? loginType;
  final String? profileImageUrl;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  Member({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    this.phone,
    this.loginType,
    this.profileImageUrl,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      phone: json['phone'] as String?,
      loginType: json['login_type'] as String?,
      profileImageUrl: json['profile_image_url'] as String?,
      role: json['role'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'login_type': loginType,
      'profile_image_url': profileImageUrl,
      'role': role,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    return other is Member && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}