// To parse this JSON data, do
//
//     final dealerModel = dealerModelFromJson(jsonString);

import 'dart:convert';

DealerModel dealerModelFromJson(String str) =>
    DealerModel.fromJson(json.decode(str));

String dealerModelToJson(DealerModel data) => json.encode(data.toJson());

class DealerModel {
  final String id;
  final String dealerId;
  final String name;
  final String phone;
  final List<Battery> battery;

  DealerModel({
    required this.id,
    required this.dealerId,
    required this.name,
    required this.phone,
    required this.battery,
  });

  factory DealerModel.fromJson(Map<String, dynamic> json) => DealerModel(
        id: json["id"],
        dealerId: json["dealer_id"],
        name: json["name"],
        phone: json["phone"],
        battery:
            List<Battery>.from(json["battery"].map((x) => Battery.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dealer_id": dealerId,
        "name": name,
        "phone": phone,
        "battery": List<dynamic>.from(battery.map((x) => x.toJson())),
      };
}

class Battery {
  final String id;
  final String userId;
  final dynamic image;
  final String name;
  final String batteryId;
  final String status;
  final String isAvailable;

  Battery({
    required this.id,
    required this.userId,
    this.image,
    required this.name,
    required this.batteryId,
    required this.status,
    required this.isAvailable,
  });

  factory Battery.fromJson(Map<String, dynamic> json) => Battery(
        id: json["id"],
        userId: json["user_id"],
        image: json["image"],
        name: json["name"],
        batteryId: json["battery_id"],
        status: json["status"],
        isAvailable: json["is_available"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "image": image,
        "name": name,
        "battery_id": batteryId,
        "status": status,
        "is_available": isAvailable,
      };
}
