// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
    final String? id;
    final String? dealerId;
    final String? name;
    final String? phone;

    UserDataModel({
        this.id,
        this.dealerId,
        this.name,
        this.phone,
    });

    factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        id: json["id"],
        dealerId: json["dealer_id"],
        name: json["name"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dealer_id": dealerId,
        "name": name,
        "phone": phone,
    };
}