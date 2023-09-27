import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/localStorage/localStorage.dart';
import 'package:service/utils/showDialouge.dart';

import 'package:service/view/homePage.dart';

import '../apiService/apiRepo.dart';
import '../utils/customToast.dart';
import '../utils/showLoadingIndicator.dart';

class SinginpageController extends GetxController {
  final signinformKey = GlobalKey<FormState>();

  RxString userName = "".obs;
  RxString userEmail = "".obs;

  late TextEditingController passController;
  late TextEditingController emailIDController;
  LocalStorageController localStorageController = Get.find();

  Future signin() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = emailIDController.text;
    data["password"] = passController.text;
    data["mobile_token"] = homepageController.pushToken.value;
    print(data);
    try {
      showloadingIndicators();
      await ApiRepo().signInApi(data).then((value) async {
        if (value["status"] == 1) {
          localStorageController.setToken(value["data"]["id"] ?? "");
          print("this is id of user");
          print(value["data"]["id"]);
          localStorageController.setUserName(value["data"]["name"] ?? "");
          localStorageController.setUserEmail(value["data"]["email"] ?? "");
          localStorageController
              .setUserImage(value["data"]["profile_image"] ?? "");
          localStorageController.setZone(value["data"]["zone"] ?? "");
          localStorageController
              .setServiceId(value["data"]["service_id"] ?? "");
          localStorageController
              .setOnlineStatus(value["data"]["is_online"] ?? "");
          localStorageController.setPhoneNo(value["data"]["phone"] ?? "");
          localStorageController
              .setSecurityPrice(value["data"]["security_price"] ?? "");
          localStorageController
              .setPermanentAdd(value["data"]["permanent_address"] ?? "");
          print("profileimgae");
          print(value["data"]["profile_image"]);
          // userImage.value =  value["data"]["profile_image"];

          customeToast(value["message"]);

          await localStorageController.getToken();
          await localStorageController.getUserEmail();
          await localStorageController.getUserName();
          await localStorageController.getUserImage();
          await localStorageController.getUserZone();
          await localStorageController.getUserServiceId();
          await localStorageController.getOnlineStatus();
          await localStorageController.getPhoneNum();
          await localStorageController.getUserServiceId();
          await localStorageController.getPermanentAddress();

          await homepageController.userAttendence();
          await homepageController.getDay();
          homepageController.getAllDealerList();
          // homepageController.statusOnline("1");
          if (homepageController.attendenceStatus.value == false) {
            homepageController.statusOnline("1");
          }
          await homepageController.serviceReport();
          homepageController.getUserList();
          await homepageController.getAllDealerList();
          await homepageController.getDriverdetail();

          await Get.to(const Homepage());
        } else {
          customeToast(value["message"]);
        }
      });
    } catch (e) {
      print(e.toString());
    }
    passController.clear();
    emailIDController.clear();
    hideLoading();
  }

  @override
  void onInit() async {
    passController = TextEditingController();
    emailIDController = TextEditingController();
    await localStorageController.getToken();
    super.onInit();
  }

  @override
  void dispose() {
    passController.dispose();
    emailIDController.dispose();
    super.dispose();
  }
}
