// To parse this JSON data, do
//
//     final swapBatteryModel = swapBatteryModelFromJson(jsonString);

import 'dart:convert';

SwapBatteryModel swapBatteryModelFromJson(String str) => SwapBatteryModel.fromJson(json.decode(str));

String swapBatteryModelToJson(SwapBatteryModel data) => json.encode(data.toJson());

class SwapBatteryModel {
    final String id;
    final String userId;
    final String driverId;
    final String batteryOne;
    final String batteryTwo;
    final String price;
    final String isReturn;
    final String returnTime;
    final String times;
    final DateTime createdOn;

    SwapBatteryModel({
        required this.id,
        required this.userId,
        required this.driverId,
        required this.batteryOne,
        required this.batteryTwo,
        required this.price,
        required this.isReturn,
        required this.returnTime,
        required this.times,
        required this.createdOn,
    });

    factory SwapBatteryModel.fromJson(Map<String, dynamic> json) => SwapBatteryModel(
        id: json["id"],
        userId: json["user_id"],
        driverId: json["driver_id"],
        batteryOne: json["battery_one"],
        batteryTwo: json["battery_two"],
        price: json["price"],
        isReturn: json["is_return"],
        returnTime: json["return_time"],
        times: json["times"],
        createdOn: DateTime.parse(json["created_on"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "driver_id": driverId,
        "battery_one": batteryOne,
        "battery_two": batteryTwo,
        "price": price,
        "is_return": isReturn,
        "return_time": returnTime,
        "times": times,
        "created_on": createdOn.toIso8601String(),
    };
}
