import 'dart:convert';

AddCardRequest addCardRequestFromJson(String str) => AddCardRequest.fromJson(json.decode(str));

String addCardRequestToJson(AddCardRequest data) => json.encode(data.toJson());

class AddCardRequest {
  AddCardRequest({
    this.cardNumber,
    this.cardDate,
    this.cvv,
  });

  String? cardNumber;
  String? cardDate;
  int? cvv;

  factory AddCardRequest.fromJson(Map<String, dynamic> json) => AddCardRequest(
    cardNumber: json["card_number"],
    cardDate: json["card_date"],
    cvv: json["cvv"],
  );

  Map<String, dynamic> toJson() => {
    "card_number": cardNumber,
    "card_date": cardDate,
    "cvv": cvv,
  };
}
