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

// TODO: - accessToken, refreshToken 만료일 각각 추가
// TODO: - Scpoes 추가
