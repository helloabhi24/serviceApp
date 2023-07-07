// To parse this JSON data, do
//
//     final serviceReportModel = serviceReportModelFromJson(jsonString);

import 'dart:convert';

ServiceReportModel serviceReportModelFromJson(String str) => ServiceReportModel.fromJson(json.decode(str));

String serviceReportModelToJson(ServiceReportModel data) => json.encode(data.toJson());

class ServiceReportModel {
    final String? id;
    final String? userId;
    final String? serviceUserId;
    final dynamic location;
    final String? serviceProblem;
    final DateTime? date;
    final String? status;
    final DateTime? createdOn;
    final String? serviceUser;
    final List<User>? user;

    ServiceReportModel({
        this.id,
        this.userId,
        this.serviceUserId,
        this.location,
        this.serviceProblem,
        this.date,
        this.status,
        this.createdOn,
        this.serviceUser,
        this.user,
    });

    factory ServiceReportModel.fromJson(Map<String, dynamic> json) => ServiceReportModel(
        id: json["id"],
        userId: json["user_id"],
        serviceUserId: json["serviceUser_id"],
        location: json["location"],
        serviceProblem: json["ServiceProblem"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        status: json["status"],
        createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
        serviceUser: json["service_user"],
        user: json["user"] == null ? [] : List<User>.from(json["user"]!.map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "serviceUser_id": serviceUserId,
        "location": location,
        "ServiceProblem": serviceProblem,
        "date": date?.toIso8601String(),
        "status": status,
        "created_on": createdOn?.toIso8601String(),
        "service_user": serviceUser,
        "user": user == null ? [] : List<dynamic>.from(user!.map((x) => x.toJson())),
    };
}

class User {
    final String? name;
    final String? email;
    final String? phone;
    final String? parmanentAddress;
    final String? switchAddress;

    User({
        this.name,
        this.email,
        this.phone,
        this.parmanentAddress,
        this.switchAddress,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        parmanentAddress: json["parmanent_address"],
        switchAddress: json["switch_address"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "parmanent_address": parmanentAddress,
        "switch_address": switchAddress,
    };
}
