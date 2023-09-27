import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/constant/constant.dart';
import 'package:service/constant/sizeHelper.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/view/chatPage.dart';

class ImagePage extends GetView<HomepageController> {
  const ImagePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await controller.sendMessage("allchats");
            controller.sliderList.clear();
            controller.selectedImagePath.value = "";
            Get.off(const ChatsWithPerson());
          },
          child: const Icon(Icons.arrow_forward),
        ),
        body: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          FileImage(File(controller.selectedImagePath.value))),
                  color: KColors.white),
            ),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: getVerticalSize(50), right: getHorizontalSize(20)),
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.cancel,
                        size: 30,
                      )),
                )),
          ],
        ));
  }
}
