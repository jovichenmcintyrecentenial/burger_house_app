
class TokenResponse {
  TokenResponse({
    required this.token,
  });

  String token;

  factory TokenResponse.fromJson(Map<String, dynamic> json) => TokenResponse(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
