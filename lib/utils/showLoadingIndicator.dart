import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/sizeHelper.dart';
import 'customText.dart';

showloadingIndicators() {
  Get.dialog(Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        getheight(Get.context, 0.010),
        const RepaintBoundary(child: CircularProgressIndicator()),
        getheight(Get.context, 0.010),
        const AppText(
          text: "Please wait....",
        )
      ],
    ),
  ));
}

hideLoading() {
  if (Get.isDialogOpen!) {
    Get.back();
  }
}
