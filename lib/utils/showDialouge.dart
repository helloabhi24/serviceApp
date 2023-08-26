import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';
import 'package:service/constant/constant.dart';
import 'package:service/controllers.dart/getBatteryController.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/localStorage/localStorage.dart';
import 'package:service/utils/customElevatedButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/sizeHelper.dart';
import '../routes.dart/appRoutes.dart';
import '../view/getBatteryPage.dart';
import 'customFormFields.dart';
import 'customText.dart';

HomepageController homepageController = Get.find();

Future<void> showMyDialog(context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const AppText(
          color: KColors.persistentBlack,
          text: "IsLogout",
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        content: const AppText(
          color: KColors.persistentBlack,
          text: "Are you sure you want to logout!",
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        actions: <Widget>[
          TextButton(
            child: AppText(
              color: KColors.persistentBlack,
              text: "Cancel",
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: AppText(
              color: KColors.persistentBlack,
              text: "Ok",
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            onPressed: () async {
              await preferences.clear();
              LocalStorageController().deleteToken();
              homepageController.statusOnline("0");
              Restart.restartApp(webOrigin: '/loginpage');
              await Get.offNamed(
                Routes.SINGINPAGE,
              );
              // Navigator.pushReplacementNamed(context, Routes.SIGNINPAGE);
            },
          ),
        ],
      );
    },
  );
}

popup(context) {
  GetDriverConnectController getDriverConnectController = Get.find();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Column(
              children: [
                AppText(
                  color: KColors.persistentBlack,
                  text: "Please Connect Driver ",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                height15,
                CustomFormField(
                  controller: homepageController.nameController,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: getVerticalSize(10),
                      horizontal: getHorizontalSize(10)),
                  hint: "Name",
                ),
                height10,
                CustomFormField(
                    controller: homepageController.phoneController,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: getVerticalSize(10),
                        horizontal: getHorizontalSize(10)),
                    hint: "PhoneNumber"),
                height5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: AppText(
                        color: KColors.persistentBlack,
                        text: "Cancel",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    TextButton(
                      child: AppText(
                        color: KColors.persistentBlack,
                        text: "Ok",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      onPressed: () async {
                        await homepageController.refer();
                        Get.back();
                      },
                    ),
                  ],
                ),
                CustomElevatedButtons(
                    isBorder: true,
                    buttoncolor: KColors.persistentBlack,
                    height: Get.height * 0.060,
                    width: Get.width * 0.99,
                    textcolor: KColors.white,
                    text: const AppText(
                      text: "All connected driver",
                    ),
                    textButton: "All connected driver",
                    ontap: () async {
                      await getDriverConnectController.getDriverConnect();
                      Get.to(GetDriverConnectPage());
                    }),
              ],
            ));
      });
}

batteryChargerProblems(context) {
  print("service user data");
  print(homepageController.serviceUserData);
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Column(
                  children: [
                    AppText(
                      color: KColors.persistentBlack,
                      text: "Generate battery qr problem",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    height10,
                    Obx(
                      () => Column(
                        children: [
                          //  addChargercustomDropdown("select problem" , homepageController.problemTypeList ,  homepageController.isshow.value),
                          height10,
                          addcharegerUserIdcustomDropdown(
                              "Users",
                              homepageController.serviceUserData,
                              homepageController.isshowDriverId.value),
                        ],
                      ),
                    ),
                    height5,
                    CustomFormField(
                      controller: homepageController.batteryID,
                      hint: "Battry ID",
                    ),
                    height5,
                    CustomFormField(
                        maxLines: true,
                        controller: homepageController.aboutProblemController,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: getVerticalSize(10),
                            horizontal: getHorizontalSize(10)),
                        hint: "Description"),
                    height5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: AppText(
                            color: KColors.persistentBlack,
                            text: "Cancel",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        TextButton(
                          child: AppText(
                            color: KColors.persistentBlack,
                            text: "OK",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () async {
                            await homepageController
                                .batteryChargerProblem("BatteryQR"
                                    // homepageController.batteryID.text
                                    );
                            Get.back();
                          },
                        ),
                      ],
                    )
                  ],
                ));
          },
        );
      });
}

batteryQrProblems(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Column(
                  children: [
                    AppText(
                      color: KColors.persistentBlack,
                      text: "Charger problem",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    height10,
                    Obx(
                      () => Column(
                        children: [
                          //  gesnertaedBatteryQrProblem( "select problem", homepageController.addProblemTypeList ,  homepageController.isshow2.value),
                          height10,
                          gesnertaedBatteryQrUserIdProblem(
                              "Users",
                              homepageController.serviceUserData,
                              homepageController.isshowDriverId2.value),
                        ],
                      ),
                    ),
                    height5,
                    CustomFormField(
                      controller: homepageController.addChargerID,
                      hint: "Changer ID",
                    ),
                    height5,
                    CustomFormField(
                        maxLines: true,
                        controller: homepageController.aboutProblemController,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: getVerticalSize(10),
                            horizontal: getHorizontalSize(10)),
                        hint: "Description"),
                    height5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: AppText(
                            color: KColors.persistentBlack,
                            text: "Cancel",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        TextButton(
                          child: AppText(
                            color: KColors.persistentBlack,
                            text: "OK",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () async {
                            await homepageController
                                .batteryChargerProblem("ChargerQR");
                            Get.back();
                          },
                        ),
                      ],
                    )
                  ],
                ));
          },
        );
      });
}

chargerQrProblems(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Column(
                  children: [
                    AppText(
                      color: KColors.persistentBlack,
                      text: "Please Add battery charger problem",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    height10,
                    Obx(
                      () => Column(
                        children: [
                          //  chargerQrDropdown("select problem" , homepageController.generateBatteryproblemTypeList ,  homepageController.isshow3.value),
                          height10,
                          chargerQrUseridDropdown(
                              "Users",
                              homepageController.serviceUserData,
                              homepageController.isshowDriverId3.value),
                        ],
                      ),
                    ),
                    height5,
                    CustomFormField(
                      controller: homepageController.chargerID,
                      hint: "Charger ID",
                    ),
                    height5,
                    CustomFormField(
                        maxLines: true,
                        controller: homepageController.aboutProblemController,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: getVerticalSize(10),
                            horizontal: getHorizontalSize(10)),
                        hint: "Description"),
                    height5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: AppText(
                            color: KColors.persistentBlack,
                            text: "Cancel",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        TextButton(
                          child: AppText(
                            color: KColors.persistentBlack,
                            text: "OK",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () async {
                            await homepageController
                                .batteryChargerProblem("AddCharger");
                            Get.back();
                          },
                        ),
                      ],
                    )
                  ],
                ));
          },
        );
      });
}

addChargercustomDropdown(String title, List list, bool isshow) {
  return Column(
    children: [
      Obx(
        () => Container(
            height: Get.height * 0.065,
            width: Get.width,
            decoration: BoxDecoration(
                border: Border.all(color: KColors.lightGrey),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AppText(
                    text: homepageController.problemType.value == ""
                        ? title
                        : homepageController.problemType.value,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      // isshow =  !isshow;
                      // homepageController.showValue.value = isshow;
                      homepageController.isshow.value =
                          !homepageController.isshow.value;

                      // homepageController.isshow.value = !homepageController.isshow.value;
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: KColors.orange,
                    ))
              ],
            )),
      ),
      homepageController.isshow.value == true
          ? SizedBox(
              height: Get.height * 0.08,
              width: 400,
              child: Obx(
                () => ListView(shrinkWrap: true, children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: KColors.grey.withOpacity(0.3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...Iterable.generate(list.length).map((e) => Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                                onTap: () {
                                  homepageController.problemType.value =
                                      homepageController.dealerList[e].name!;
                                  homepageController.isshow.value = false;
                                  // isshow = false;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: AppText(
                                    text: list[e],
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ))))
                      ],
                    ),
                  ),
                ]),
              ),
            )
          : const SizedBox()
    ],
  );
}

addcharegerUserIdcustomDropdown(String title, List list, bool isshow) {
  return Column(
    children: [
      Obx(
        () => Container(
            height: Get.height * 0.065,
            width: Get.width,
            decoration: BoxDecoration(
                border: Border.all(color: KColors.lightGrey),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AppText(
                    text: homepageController.userIdvalue.value == ""
                        ? title
                        : homepageController.userIdvalue.value,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      homepageController.isshowDriverId2.value =
                          !homepageController.isshowDriverId2.value;
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: KColors.orange,
                    ))
              ],
            )),
      ),
      homepageController.isshowDriverId2.value == true
          ? SizedBox(
              width: 400,
              child: Obx(
                () => ListView(shrinkWrap: true, children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: KColors.grey.withOpacity(0.3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...Iterable.generate(
                                homepageController.dealerList.length)
                            .map((e) => Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                    onTap: () {
                                      homepageController.userIdvalue.value =
                                          homepageController
                                              .dealerList[e].name!;
                                      homepageController.isshowDriverId2.value =
                                          false;
                                      homepageController.userId.value =
                                          homepageController.dealerList[e].id!;
                                      // isshow = false;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: AppText(
                                        text: homepageController
                                            .dealerList[e].name!,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ))))
                      ],
                    ),
                  ),
                ]),
              ),
            )
          : const SizedBox()
    ],
  );
}

gesnertaedBatteryQrProblem(String title, List list, bool isshow) {
  return Column(
    children: [
      Obx(
        () => Container(
            height: Get.height * 0.065,
            width: Get.width,
            decoration: BoxDecoration(
                border: Border.all(color: KColors.lightGrey),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AppText(
                    text: homepageController.problemType2.value == ""
                        ? title
                        : homepageController.problemType2.value,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      // isshow =  !isshow;
                      // homepageController.showValue.value = isshow;
                      homepageController.isshow2.value =
                          !homepageController.isshow2.value;

                      // homepageController.isshow.value = !homepageController.isshow.value;
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: KColors.orange,
                    ))
              ],
            )),
      ),
      homepageController.isshow2.value == true
          ? SizedBox(
              height: Get.height * 0.08,
              width: 400,
              child: Obx(
                () => ListView(shrinkWrap: true, children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: KColors.grey.withOpacity(0.3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...Iterable.generate(list.length).map((e) => Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                                onTap: () {
                                  homepageController.problemType2.value =
                                      list[e];
                                  homepageController.isshow2.value = false;
                                  // isshow = false;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: AppText(
                                    text: list[e],
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ))))
                      ],
                    ),
                  ),
                ]),
              ),
            )
          : const SizedBox()
    ],
  );
}

gesnertaedBatteryQrUserIdProblem(String title, List list, bool isshow) {
  return Column(
    children: [
      Obx(
        () => Container(
            height: Get.height * 0.065,
            width: Get.width,
            decoration: BoxDecoration(
                border: Border.all(color: KColors.lightGrey),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AppText(
                    text: homepageController.problemType.value == ""
                        ? title
                        : homepageController.problemType.value,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      // isshow =  !isshow;
                      // homepageController.showValue.value = isshow;
                      homepageController.isshow.value =
                          !homepageController.isshow.value;

                      // homepageController.isshow.value = !homepageController.isshow.value;
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: KColors.orange,
                    ))
              ],
            )),
      ),
      homepageController.isshow.value == true
          ? SizedBox(
              // height: Get.height * 0.08,
              width: 400,
              child: Obx(
                () => ListView(shrinkWrap: true, children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: KColors.grey.withOpacity(0.3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...Iterable.generate(
                                homepageController.dealerList.length)
                            .map((e) => Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                    onTap: () {
                                      homepageController.userId.value =
                                          homepageController.dealerList[e].id!;
                                      homepageController.problemType.value =
                                          homepageController
                                              .dealerList[e].name!;
                                      homepageController.isshow.value = false;
                                      // isshow = false;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: AppText(
                                        text: homepageController
                                            .dealerList[e].name!,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ))))
                      ],
                    ),
                  ),
                ]),
              ),
            )
          : const SizedBox()
    ],
  );
}

chargerQrDropdown(String title, List list, bool isshow) {
  return Column(
    children: [
      Obx(
        () => Container(
            height: Get.height * 0.065,
            width: Get.width,
            decoration: BoxDecoration(
                border: Border.all(color: KColors.lightGrey),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AppText(
                    text: homepageController.problemType3.value == ""
                        ? title
                        : homepageController.problemType3.value,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      // isshow2 =  !isshow2;

                      // homepageController.showValue.value = isshow;
                      homepageController.isshow3.value =
                          !homepageController.isshow3.value;

                      // homepageController.isshow.value = !homepageController.isshow.value;
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: KColors.orange,
                    ))
              ],
            )),
      ),
      homepageController.isshow3.value == true
          ? SizedBox(
              height: Get.height * 0.08,
              width: 400,
              child: Obx(
                () => ListView(shrinkWrap: true, children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: KColors.grey.withOpacity(0.3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...Iterable.generate(list.length).map((e) => Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                                onTap: () {
                                  homepageController.problemType3.value =
                                      list[e];
                                  homepageController.isshow3.value = false;
                                  // isshow = false;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: AppText(
                                    text: list[e],
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ))))
                      ],
                    ),
                  ),
                ]),
              ),
            )
          : const SizedBox()
    ],
  );
}

chargerQrUseridDropdown(String title, List list, bool isshow) {
  return Column(
    children: [
      Obx(
        () => Container(
            height: Get.height * 0.065,
            width: Get.width,
            decoration: BoxDecoration(
                border: Border.all(color: KColors.lightGrey),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AppText(
                    text: homepageController.problemType.value == ""
                        ? title
                        : homepageController.problemType.value,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      homepageController.isshow.value =
                          !homepageController.isshow.value;
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: KColors.orange,
                    ))
              ],
            )),
      ),
      homepageController.isshow.value == true
          ? SizedBox(
              // height: Get.height * 0.15,
              width: 400,
              child: Obx(
                () => ListView(shrinkWrap: true, children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: KColors.grey.withOpacity(0.3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...Iterable.generate(
                                homepageController.dealerList.length)
                            .map((e) => Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                    onTap: () {
                                      homepageController.userId.value =
                                          homepageController.dealerList[e].id!;
                                      homepageController.problemType.value =
                                          homepageController
                                              .dealerList[e].name!;
                                      homepageController.isshow.value = false;
                                      // isshow = false;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: AppText(
                                        text: homepageController
                                            .dealerList[e].name!,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ))))
                      ],
                    ),
                  ),
                ]),
              ),
            )
          : const SizedBox()
    ],
  );
}

viewDriverDetails(context, index) {
  HomepageController homepageController = Get.find();
  return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) {
        return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getHorizontalSize(10)),
                      height: Get.height * 0.05,
                      decoration: BoxDecoration(
                          color: KColors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: "Total driver",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          AppText(
                            text: homepageController
                                .getDriverDetailList[index].driver!.length
                                .toString(),
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: homepageController
                              .getDriverDetailList[index].driver!.isEmpty
                          ? 0
                          : Get.height * 0.45,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index1) {
                          return Container(
                            height: Get.height * 0.38,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                border: Border.all(color: KColors.lightGrey),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: "Id",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      AppText(
                                        text: homepageController
                                                .getDriverDetailList[index]
                                                .driver![index1]
                                                .id ??
                                            "",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: KColors.persistentBlack
                                            .withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: "DriverId",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      AppText(
                                        text: homepageController
                                                .getDriverDetailList[index]
                                                .driver![index1]
                                                .driverId ??
                                            "",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: KColors.persistentBlack
                                            .withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: "UserId",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      AppText(
                                        text: homepageController
                                                .getDriverDetailList[index]
                                                .driver![index1]
                                                .userId ??
                                            "",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: KColors.persistentBlack
                                            .withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: "ProfileImage",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      AppText(
                                        text: homepageController
                                                .getDriverDetailList[index]
                                                .driver![index1]
                                                .profileImage ??
                                            "",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: KColors.persistentBlack
                                            .withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: "Name",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      AppText(
                                        text: homepageController
                                                .getDriverDetailList[index]
                                                .driver![index1]
                                                .name ??
                                            "",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: KColors.persistentBlack
                                            .withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: "Security",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      AppText(
                                        text: homepageController
                                                .getDriverDetailList[index]
                                                .driver![index1]
                                                .security ??
                                            "",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: KColors.persistentBlack
                                            .withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: "Name",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      AppText(
                                        text: homepageController
                                                .getDriverDetailList[index]
                                                .driver![index1]
                                                .name ??
                                            "",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: KColors.persistentBlack
                                            .withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: "Phone",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      AppText(
                                        text: homepageController
                                                .getDriverDetailList[index]
                                                .driver![index1]
                                                .phone ??
                                            "",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: KColors.persistentBlack
                                            .withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: "Addhar Number",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      AppText(
                                        text: homepageController
                                                .getDriverDetailList[index]
                                                .driver![index1]
                                                .adharGstinPan ??
                                            "",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: KColors.persistentBlack
                                            .withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: "Penality",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      AppText(
                                        text: homepageController
                                                .getDriverDetailList[index]
                                                .driver![index1]
                                                .penality ??
                                            "",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: KColors.persistentBlack
                                            .withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: "Created",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      AppText(
                                        text: homepageController
                                            .getDriverDetailList[index]
                                            .driver![index1]
                                            .createdOn!
                                            .toString()
                                            .split("00:00:00.000")
                                            .first,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: KColors.persistentBlack
                                            .withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: homepageController
                            .getDriverDetailList[index].driver!.length,
                      ),
                    ),
                  ],
                ))
            //    Column(
            //     children: [
            //       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //       AppText(
            //     text: "Id",
            //     fontSize: 16.sp,
            //      fontWeight: FontWeight.w700,
            //   ),
            //     AppText(
            //     text: homepageController.getDriverDetailList[index].name!,
            //     fontSize: 16.sp,
            //      fontWeight: FontWeight.w700,
            //   ),
            //       ],),
            //       height5,
            //        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //       AppText(
            //     text: "DealerId",
            //     fontSize: 16.sp,
            //      fontWeight: FontWeight.w700,
            //   ),
            //     AppText(
            //     text: homepageController.getDriverDetailList[index].name!,
            //     fontSize: 16.sp,
            //      fontWeight: FontWeight.w700,
            //   ),
            //       ],),
            //       height5,
            //        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //       AppText(
            //     text: "name",
            //     fontSize: 16.sp,
            //      fontWeight: FontWeight.w700,
            //   ),
            //     AppText(
            //     text: homepageController.dealerList[index].name!,
            //     fontSize: 16.sp,
            //      fontWeight: FontWeight.w700,
            //   ),
            //       ],),
            //       height5,
            //        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //       AppText(
            //     text: "Phone",
            //     fontSize: 16.sp,
            //      fontWeight: FontWeight.w700,
            //   ),
            //     AppText(
            //     text: homepageController.dealerList[index].phone!,
            //     fontSize: 16.sp,
            //      fontWeight: FontWeight.w700,
            //   ),
            //       ],),

            //       // SizedBox(height: homepageController.dealerList[index].battery!.isNotEmpty? Get.height*0.24 : 0,width: 500,
            //       //   child: ListView.builder(shrinkWrap: true,
            //       //     itemBuilder: (context, index1){
            //       //     return Padding(
            //       //       padding: const EdgeInsets.all(8.0),
            //       //       child: AppText(text: homepageController.dealerList[index].battery![index1].name!,),
            //       //     );
            //       //   },itemCount: homepageController.dealerList[index].battery!.length,),
            //       // )
            //     ],
            //  ),

            );
      });
}

viewDealerDetails(context, index) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: KColors.redColor.withOpacity(0.17),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Align(
              alignment: Alignment.center,
              child: SizedBox(
                child: Column(
                  children: [
                    AppText(
                      text: "Dealer Details",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      // wordSpacing: 1,
                    ),
                    height18,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: "Dealer Id",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        AppText(
                          text:
                              homepageController.getdealerList[index].dealerId!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    height5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: "Name",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        AppText(
                          text: homepageController.getdealerList[index].name!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    height5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: "Email Id",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        AppText(
                          text: homepageController.getdealerList[index].email!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    height5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: "Phone Number",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        AppText(
                          text: homepageController.getdealerList[index].phone!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    height5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: "Service Price",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        AppText(
                          text: homepageController
                              .getdealerList[index].securityPrice!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    height5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: "Online",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        AppText(
                          text:
                              homepageController.getdealerList[index].isOnline!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    height5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: "Permanent Address ",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        Expanded(
                          child: AppText(
                            text: homepageController
                                .getdealerList[index].parmanentAddress!,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            // textOverflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    height5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: "Switch Address ",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        Expanded(
                          child: AppText(
                            text: homepageController
                                .getdealerList[index].switchAddress!,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            // textOverflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        );
      });
}
