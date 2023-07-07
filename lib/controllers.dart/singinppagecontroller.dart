import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/localStorage/localStorage.dart';

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
   LocalStorageController localStorageController =  Get.find();

    Future signin() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = emailIDController.text;
    data["password"] = passController.text;
    try {
     showloadingIndicators();
      await ApiRepo().signInApi(data).then((value) async {
         if(value["status"]== 1){
          localStorageController.setToken(value["data"]["id"]);
          localStorageController.setUserName(value["data"]["name"]);
          localStorageController.setUserEmail(value["data"]["email"]);
          localStorageController.setUserImage(value["data"]["profile_image"]);
          print("profileimgae");
          print(value["data"]["profile_image"]);
          // userImage.value =  value["data"]["profile_image"];

          customeToast(value["message"]);
           await Get.to(const Homepage());
         }else{
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
