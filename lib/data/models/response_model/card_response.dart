import 'dart:convert';

List<CardResponse> cardResponseFromJson(String str) => List<CardResponse>.from(json.decode(str).map((x) => CardResponse.fromJson(x)));

String cardResponseToJson(List<CardResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CardResponse {
  CardResponse({
    this.cardNumber,
    this.cardDate,
    this.cvv,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  String? cardNumber;
  String? cardDate;
  int? cvv;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CardResponse.fromJson(Map<String, dynamic> json) => CardResponse(
    cardNumber: json["card_number"],
    cardDate: json["card_date"],
    cvv: json["cvv"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "card_number": cardNumber,
    "card_date": cardDate,
    "cvv": cvv,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  String getMaskedNumber() {
    return "**** ***** ***** "+cardNumber!.substring(cardNumber!.length-4,cardNumber!.length);
  }
}
