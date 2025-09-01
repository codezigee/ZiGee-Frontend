class AuthToken {
  final String accessToken;
  final String? refreshToken;
  final DateTime expireAt;

  AuthToken({
    required this.accessToken,
    this.refreshToken,
    required this.expireAt,
  });
}
