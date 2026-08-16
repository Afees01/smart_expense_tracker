class Loginmodel {
  final String token;

  Loginmodel({
    required this.token,
  });

  factory Loginmodel.fromJson(Map<String, dynamic> json) {
    return Loginmodel(
      token: json["data"]["token"] ?? "",
    );
  }
}