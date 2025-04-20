class AuthToken {
  String acessToken;
  String refreshToken;
  String role;
  String pId;

  AuthToken(
      {required this.acessToken,
      required this.refreshToken,
      required this.role,
      required this.pId});
}
