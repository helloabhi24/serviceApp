// To parse this JSON data, do
//
//     final dealerModel = dealerModelFromJson(jsonString);

import 'dart:convert';

DealerModel dealerModelFromJson(String str) => DealerModel.fromJson(json.decode(str));

String dealerModelToJson(DealerModel data) => json.encode(data.toJson());

class DealerModel {
    final String? id;
    final String? dealerId;
    final String? name;
    final String? phone;
    final List<Battery>? battery;

    DealerModel({
        this.id,
        this.dealerId,
        this.name,
        this.phone,
        this.battery,
    });

    factory DealerModel.fromJson(Map<String, dynamic> json) => DealerModel(
        id: json["id"],
        dealerId: json["dealer_id"],
        name: json["name"],
        phone: json["phone"],
        battery: json["battery"] == null ? [] : List<Battery>.from(json["battery"]!.map((x) => Battery.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dealer_id": dealerId,
        "name": name,
        "phone": phone,
        "battery": battery == null ? [] : List<dynamic>.from(battery!.map((x) => x.toJson())),
    };
}

class Battery {
    final String? id;
    final String? userId;
    final String? name;
    final String? batteryId;

    Battery({
        this.id,
        this.userId,
        this.name,
        this.batteryId,
    });

    factory Battery.fromJson(Map<String, dynamic> json) => Battery(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        batteryId: json["battery_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "battery_id": batteryId,
    };
}
