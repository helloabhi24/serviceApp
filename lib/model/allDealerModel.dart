
// To parse this JSON data, do
//
//     final dealerListModel = dealerListModelFromJson(jsonString);

import 'dart:convert';

DealerListModel dealerListModelFromJson(String str) => DealerListModel.fromJson(json.decode(str));

String dealerListModelToJson(DealerListModel data) => json.encode(data.toJson());

class DealerListModel {
    final String? id;
    final String? dealerId;
    final String? profileImage;
    final String? multipleAttachment;
    final String? name;
    final String? email;
    final String? phone;
    final String? mobileToken;
    final String? password;
    final dynamic adharGstinPan;
    final String? service;
    final String? securityPrice;
    final String? status;
    final String? isOnline;
    final String? parmanentAddress;
    final String? switchAddress;

    DealerListModel({
        this.id,
        this.dealerId,
        this.profileImage,
        this.multipleAttachment,
        this.name,
        this.email,
        this.phone,
        this.mobileToken,
        this.password,
        this.adharGstinPan,
        this.service,
        this.securityPrice,
        this.status,
        this.isOnline,
        this.parmanentAddress,
        this.switchAddress,
    });

    factory DealerListModel.fromJson(Map<String, dynamic> json) => DealerListModel(
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
    };
}
