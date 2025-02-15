class AuthToken {
  String acessToken;
  String refreshToken;
  String role;

  AuthToken(
      {required this.acessToken,
      required this.refreshToken,
      required this.role});
}
