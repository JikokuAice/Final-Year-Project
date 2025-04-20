class TokenModel {
  String
      acessToken; // has short expirary and used for authorization and authentication.
  String refreshToken;
  String role; // to generate new access token after its expiry
  String pId;
  TokenModel(
      {required this.acessToken,
      required this.refreshToken,
      required this.role,
      required this.pId});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
        acessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
        role: json['role'],
        pId: json['primarySid']);
  }

  Map<String, dynamic> tojson() {
    return {
      "accessToken": acessToken,
      "refreshToken": refreshToken,
      "role": role,
      "pId": pId,
    };
  }
}
