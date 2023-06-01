import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/constant/constant.dart';

import '../constant/sizeHelper.dart';

SnackbarController? errorSnackbar(String msg,
    {VoidCallback? onTap, String? btnText}) {
  if (!Get.isSnackbarOpen) {
    return Get.rawSnackbar(
      message: msg.capitalize,
      borderWidth: 2,
      borderRadius: 10,
      borderColor: KColors.red,
      margin: EdgeInsets.only(
          top: 10, left: getHorizontalSize(20), right: getHorizontalSize(20)),
      isDismissible: true,
      dismissDirection: GetPlatform.isAndroid
          ? DismissDirection.horizontal
          : DismissDirection.vertical,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.dangerous, color: Colors.white),
      forwardAnimationCurve: Curves.bounceIn,
      mainButton: TextButton(
          onPressed: onTap ??
              () {
                Get.back();
              },
          child: Text(btnText ?? "Dismiss",
              style: const TextStyle(
                color: KColors.red,
              ))),
      snackPosition: SnackPosition.TOP,
      backgroundColor: KColors.persistentBlack,
    );
  }
  return null;
}
