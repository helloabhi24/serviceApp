// To parse this JSON data, do
//
//     final driverModel = driverModelFromJson(jsonString);

import 'dart:convert';

DriverModel driverModelFromJson(String str) => DriverModel.fromJson(json.decode(str));

String driverModelToJson(DriverModel data) => json.encode(data.toJson());

class DriverModel {
    final String? id;
    final String? userId;
    final String? name;
    final List<Driver>? driver;

    DriverModel({
        this.id,
        this.userId,
        this.name,
        this.driver,
    });

    factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        driver: json["driver"] == null ? [] : List<Driver>.from(json["driver"]!.map((x) => Driver.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "driver": driver == null ? [] : List<dynamic>.from(driver!.map((x) => x.toJson())),
    };
}

class Driver {
    final String? id;
    final String? driverId;
    final String? userId;
    final dynamic profileImage;
    final String? name;
    final String? security;
    final String? attachment;
    final String? phone;
    final String? adharGstinPan;
    final String? penality;
    final String? status;
    final DateTime? createdOn;

    Driver({
        this.id,
        this.driverId,
        this.userId,
        this.profileImage,
        this.name,
        this.security,
        this.attachment,
        this.phone,
        this.adharGstinPan,
        this.penality,
        this.status,
        this.createdOn,
    });

    factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        driverId: json["driver_id"],
        userId: json["user_id"],
        profileImage: json["profile_image"],
        name: json["name"],
        security: json["security"],
        attachment: json["attachment"],
        phone: json["phone"],
        adharGstinPan: json["adhar_gstin_pan"],
        penality: json["penality"],
        status: json["status"],
        createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "driver_id": driverId,
        "user_id": userId,
        "profile_image": profileImage,
        "name": name,
        "security": security,
        "attachment": attachment,
        "phone": phone,
        "adhar_gstin_pan": adharGstinPan,
        "penality": penality,
        "status": status,
        "created_on": "${createdOn!.year.toString().padLeft(4, '0')}-${createdOn!.month.toString().padLeft(2, '0')}-${createdOn!.day.toString().padLeft(2, '0')}",
    };
}
