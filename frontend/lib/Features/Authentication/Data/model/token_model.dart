import 'package:flutter/foundation.dart';

class TokenModel {
  String
      acessToken; // has short expirary and used for authorization and authentication.
  String refreshToken; // to generate new access token after its expiry

  TokenModel({required this.acessToken, required this.refreshToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
        acessToken: json['accessToken'], refreshToken: json['refreshToken']);
  }

  Map<String, dynamic> tojson() {
    return {"accessToken": acessToken, "refreshToken": refreshToken};
  }
}
