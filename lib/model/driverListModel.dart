// To parse this JSON data, do
//
//     final driverListModel = driverListModelFromJson(jsonString);

import 'dart:convert';

DriverListModel driverListModelFromJson(String str) =>
    DriverListModel.fromJson(json.decode(str));

String driverListModelToJson(DriverListModel data) =>
    json.encode(data.toJson());

class DriverListModel {
  final String id;
  final dynamic userId;
  final String serviceUserId;
  final String name;
  final String phone;
  final String status;

  DriverListModel({
    required this.id,
    required this.userId,
    required this.serviceUserId,
    required this.name,
    required this.phone,
    required this.status,
  });

  factory DriverListModel.fromJson(Map<String, dynamic> json) =>
      DriverListModel(
        id: json["id"],
        userId: json["user_id"],
        serviceUserId: json["serviceUser_id"],
        name: json["name"],
        phone: json["phone"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "serviceUser_id": serviceUserId,
        "name": name,
        "phone": phone,
        "status": status,
      };
}
