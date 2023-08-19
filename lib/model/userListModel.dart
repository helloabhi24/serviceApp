// To parse this JSON data, do
//
//     final userListModel = userListModelFromJson(jsonString);

import 'dart:convert';

UserListModel userListModelFromJson(String str) =>
    UserListModel.fromJson(json.decode(str));

String userListModelToJson(UserListModel data) => json.encode(data.toJson());

class UserListModel {
  final String id;
  final String dealerId;
  final String name;
  final String phone;

  UserListModel({
    required this.id,
    required this.dealerId,
    required this.name,
    required this.phone,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
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
