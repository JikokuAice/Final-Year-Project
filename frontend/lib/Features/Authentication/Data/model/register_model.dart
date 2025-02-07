class RegisterModel {
  final String name;
  final String email;
  final String password;
  final String image;

  RegisterModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.image});

  Map<String, dynamic> tojson() {
    return {"name": name, "email": email, "password": password, "image": image};
  }
}


