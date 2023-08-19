import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/controllers.dart/singinppagecontroller.dart';
import 'package:service/localStorage/localStorage.dart';
import 'package:service/utils/constant.dart';
import 'package:service/utils/customText.dart';
import 'package:service/utils/textExtension.dart';
import '../constant/constant.dart';
import '../constant/sizeHelper.dart';
import '../utils/customAssetsImage.dart';
import '../view/chatPage.dart';

//  HomepageController homepageController = Get.find();
// LocalStorageController localStorageController = Get.find();

class HomePageWidget {
  HomepageController homepageController = Get.find();
  static customeAppbar(context) {
    return AppBar(
      backgroundColor: KColors.persistentBlack,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAssetsImage(
            imagePath: Constant().logo,
            height: Get.height * 0.06,
          ),
          getWidth(context, 0.010),
          "SwitchX".f18w7(fontSize: 20.sp)
        ],
      ),
      // actions: [
      //   Row(
      //     children: [
      //       GestureDetector(
      //           onTap: () {
      //             Get.to(const ChatsWithPerson());
      //           },
      //           child: Padding(
      //             padding: const EdgeInsets.all(12.0),
      //             child: const Icon(
      //               Icons.chat,
      //               size: 20,
      //             ),
      //           )),
      //       // Padding(
      //       //   padding: const EdgeInsets.all(12.0),
      //       //   child: Stack(
      //       //     alignment: Alignment.topRight,
      //       //     children: [
      //       //       GestureDetector(
      //       //           behavior: HitTestBehavior.translucent,
      //       //           onTap: () async {
      //       //             // Get.to(const ChatsWithPerson());
      //       //             // homepageController.serviceReport();
      //       //           },
      //       //           child: const Icon(Icons.notifications)),
      //       //       const CircleAvatar(radius: 5, backgroundColor: KColors.red)
      //       //     ],
      //       //   ),
      //       // ),
      //     ],
      //   )
      // ]
    );
  }
}

class AppBarWidget {
  HomepageController homepageController = Get.find();
  static customeAppbar(context) {
    return AppBar(
      backgroundColor: KColors.persistentBlack,
      // centerTitle: true,
      title: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getWidth(context, 0.14),
          CustomAssetsImage(
            imagePath: Constant().logo,
            height: Get.height * 0.06,
          ),
          getWidth(context, 0.010),
          "SwitchX".f18w7(fontSize: 20.sp)
        ],
      ),
    );
  }
}

class UserDetail extends GetView<HomepageController> {
  const UserDetail({super.key});
  @override
  Widget build(BuildContext context) {
    LocalStorageController localStorageController = Get.find();
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.determinePosition();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: getVerticalSize(9), horizontal: getHorizontalSize(5)),
          child: Container(
            height: Get.height * 0.08,
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: KColors.orange
                color: KColors.redColor.withOpacity(0.17)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(14)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      width8,
                      localStorageController.userImage.value.isEmpty
                          ? CircleAvatar(
                              child: Icon(Icons.person),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://admin.switchxenergy.com/uploads/user_service/${localStorageController.userImage.value}"))),
                              height: 42,
                              width: 42,
                            ),
                      //  CircleAvatar(
                      //   backgroundColor: KColors.white,
                      //   child:
                      //    Image.network("https://admin.switchxenergy.com/uploads/user_service/${localStorageController.userImage.value}")
                      // ),
                      width15,
                      localStorageController.userName.value.isEmpty
                          ? const AppText(
                              text: "no Name",
                              color: KColors.background,
                            )
                          : localStorageController.userName.value.f18w6(
                              fontWeight: FontWeight.w600,
                              fontSize: 17.sp,
                              textColor: KColors.background),
                      width25
                    ],
                  ),
                  "SE012\nNorth-zone".f16w6(
                      textAlign: TextAlign.center,
                      fontSize: 14.sp,
                      // fontWeight: FontWeight.w400,
                      textColor: KColors.background),
                  width2
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserActivationPage extends GetView<HomepageController> {
  const UserActivationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(
            vertical: getVerticalSize(9), horizontal: getHorizontalSize(5)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(10)),
          height: Get.height * 0.07,
          width: Get.width,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              blurRadius: 10.0,
            ),
          ], borderRadius: BorderRadius.circular(10), color: KColors.white),
          child: Row(
            children: [
              width15,
              CircleAvatar(
                radius: 5.h,
                backgroundColor: controller.isUpdated.value == true
                    ? KColors.green
                    : KColors.grey,
              ),
              width13,
              controller.isUpdated.value == true
                  ? "Online"
                      .f18w6(textColor: KColors.persistentBlack, fontSize: 15)
                  : "Offline"
                      .f18w6(textColor: KColors.persistentBlack, fontSize: 15),
              // Row(
              //   children: [
              //     Switch(
              //         activeColor: KColors.green,
              //         value: controller.isUpdated.value,

              //         // homepageController.isStatus.value,
              //         onChanged: (v) async {
              //           controller.isStatus.value = v;
              //           // homepageController.statusOnline(homepageController.isStatus.value ==true?"1":"0" );
              //         }),
              //   ],
              // ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015),
                      lastDate: DateTime(2029));
                  if (picked != null) {
                    controller.selectedDate.value =
                        picked.toString().split("00:00:00.000").first;
                    await controller.attendence();
                  }
                },
                child: Row(
                  children: [
                    "Attendance".f18w6(
                        textColor: KColors.persistentBlack, fontSize: 15),
                    width5,
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    ),
                    width5
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
