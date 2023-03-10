// To parse this JSON data, do
//
//     final menuItem = menuItemFromJson(jsonString);

import 'dart:convert';

List<MenuItem> menuItemFromJson(String str) => List<MenuItem>.from(json.decode(str).map((x) => MenuItem.fromJson(x)));

String menuItemToJson(List<MenuItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuItem {
  MenuItem({
    this.id,
    this.name,
    this.imageUrl,
    this.type,
    this.calories,
    this.likes,
    this.prepareTime,
    this.price,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? name;
  String? imageUrl;
  String? type;
  int? calories;
  int? likes;
  int? prepareTime;
  double? price;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
    id: json["_id"],
    name: json["name"],
    imageUrl: json["image_url"],
    type: json["type"],
    calories: json["calories"],
    likes: json["likes"],
    prepareTime: json["prepare_time"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image_url": imageUrl,
    "type": type,
    "calories": calories,
    "likes": likes,
    "prepare_time": prepareTime,
    "price": price,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
