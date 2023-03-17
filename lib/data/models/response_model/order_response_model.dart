import 'dart:convert';

import 'package:burger_house/data/models/response_model/menu_item.dart';
import 'package:burger_house/utils/formatters/number_formtter.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.menuItems,
    this.fees,
    this.customerId,
    this.total,
    this.isActive,
    this.isVerified,
    this.isDelivered,
    this.id,
  });

  List<MenuItem>? menuItems;
  List<Fee>? fees;
  String? customerId;
  double? total;
  bool? isActive;
  bool? isVerified;
  bool? isDelivered;
  String? id;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    menuItems: json["menu_items"] == null ? [] : List<MenuItem>.from(json["menu_items"]!.map((x) => MenuItem.fromJson(x))),
    fees: json["fees"] == null ? [] : List<Fee>.from(json["fees"]!.map((x) => Fee.fromJson(x))),
    customerId: json["customer_id"],
    total: json["total"]?.toDouble(),
    isActive: json["is_active"],
    isVerified: json["is_verified"],
    isDelivered: json["is_delivered"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "menu_items": menuItems == null ? [] : List<dynamic>.from(menuItems!.map((x) => x.toJson())),
    "fees": fees == null ? [] : List<dynamic>.from(fees!.map((x) => x.toJson())),
    "customer_id": customerId,
    "total": total,
    "is_active": isActive,
    "is_verified": isVerified,
    "is_delivered": isDelivered,
    "_id": id,
  };

  String getTotalFormatted(){

    return NumberFormatter.format(amount: total.toString(),dp: 2);
  }
}

class Fee {
  Fee({
    this.name,
    this.price,
    this.id,
    this.v,
  });

  String? name;
  double? price;
  String? id;
  int? v;

  String getPriceFormatted(){

    return NumberFormatter.format(amount: price.toString(),dp: 2);
  }


  factory Fee.fromJson(Map<String, dynamic> json) => Fee(
    name: json["name"],
    price: json["price"]?.toDouble(),
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "_id": id,
    "__v": v,
  };
}

