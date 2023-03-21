import 'dart:convert';

AddAddressRequest addAddressRequestFromJson(String str) => AddAddressRequest.fromJson(json.decode(str));

String addAddressRequestToJson(AddAddressRequest data) => json.encode(data.toJson());

class AddAddressRequest {
  AddAddressRequest({
    this.address,
    this.latitude,
    this.longitude,
  });

  String? address;
  double? latitude;
  double? longitude;

  factory AddAddressRequest.fromJson(Map<String, dynamic> json) => AddAddressRequest(
    address: json["address"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
  };
}
