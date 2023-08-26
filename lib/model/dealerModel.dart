// To parse this JSON data, do
//
//     final dealerModel = dealerModelFromJson(jsonString);

import 'dart:convert';

DealerModel dealerModelFromJson(String str) =>
    DealerModel.fromJson(json.decode(str));

String dealerModelToJson(DealerModel data) => json.encode(data.toJson());

class DealerModel {
  final dynamic id;
  final dynamic dealerId;
  final dynamic profileImage;
  final dynamic multipleAttachment;
  final dynamic name;
  final dynamic email;
  final dynamic phone;
  final dynamic mobileToken;
  final dynamic password;
  final dynamic adharGstinPan;
  final dynamic service;
  final dynamic securityPrice;
  final dynamic status;
  final dynamic isOnline;
  final dynamic parmanentAddress;
  final dynamic switchAddress;
  final List<Battery> battery;

  DealerModel({
    required this.id,
    required this.dealerId,
    required this.profileImage,
    required this.multipleAttachment,
    required this.name,
    required this.email,
    required this.phone,
    required this.mobileToken,
    required this.password,
    this.adharGstinPan,
    required this.service,
    required this.securityPrice,
    required this.status,
    required this.isOnline,
    required this.parmanentAddress,
    required this.switchAddress,
    required this.battery,
  });

  factory DealerModel.fromJson(Map<String, dynamic> json) => DealerModel(
        id: json["id"],
        dealerId: json["dealer_id"],
        profileImage: json["profile_image"],
        multipleAttachment: json["multiple_attachment"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        mobileToken: json["mobile_token"],
        password: json["password"],
        adharGstinPan: json["adhar_gstin_pan"],
        service: json["service"],
        securityPrice: json["security_price"],
        status: json["status"],
        isOnline: json["is_online"],
        parmanentAddress: json["parmanent_address"],
        switchAddress: json["switch_address"],
        battery:
            List<Battery>.from(json["battery"].map((x) => Battery.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dealer_id": dealerId,
        "profile_image": profileImage,
        "multiple_attachment": multipleAttachment,
        "name": name,
        "email": email,
        "phone": phone,
        "mobile_token": mobileToken,
        "password": password,
        "adhar_gstin_pan": adharGstinPan,
        "service": service,
        "security_price": securityPrice,
        "status": status,
        "is_online": isOnline,
        "parmanent_address": parmanentAddress,
        "switch_address": switchAddress,
        "battery": List<dynamic>.from(battery.map((x) => x.toJson())),
      };
}

class Battery {
  final String id;
  final String userId;
  final String name;
  final String batteryId;

  Battery({
    required this.id,
    required this.userId,
    required this.name,
    required this.batteryId,
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
