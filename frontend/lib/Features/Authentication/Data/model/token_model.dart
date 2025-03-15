class TokenModel {
  String
      acessToken; // has short expirary and used for authorization and authentication.
  String refreshToken;
  String role; // to generate new access token after its expiry

  TokenModel(
      {required this.acessToken,
      required this.refreshToken,
      required this.role});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
        acessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
        role: json['role']);
  }

  Map<String, dynamic> tojson() {
    return {
      "accessToken": acessToken,
      "refreshToken": refreshToken,
      "role": role
    };
  }
}
