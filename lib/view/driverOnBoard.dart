import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/utils/colors.dart';
import 'package:service/utils/customAssetsImage.dart';
import 'package:service/utils/customText.dart';
import 'package:service/utils/customToast.dart';
import 'package:service/utils/textExtension.dart';
import 'package:service/widgets/dropDownWidget.dart';
import '../constant/constant.dart';
import '../constant/sizeHelper.dart';
import '../utils/constant.dart';
import '../utils/customFormFields.dart';

class DriverOnBoardPage extends GetView<HomepageController> {
  const DriverOnBoardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: KColors.lightRedColor,
        // backgroundColor: KColors.red.withOpacity(0.1),
        // backgroundColor: Colors.red[50],
        appBar: AppBar(
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
          actions: [
            CircleAvatar(
              backgroundColor: KColors.persistentBlack,
            )
          ],
          // const AppText(
          //   text: "BatteryAndChargerPage",
          // ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getVerticalSize(20),
                  horizontal: getHorizontalSize(10)),
              child: Column(
                children: [
                  AppText(
                    text: "Dealer",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getheight(context, 0.020),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              controller.isNewDealer.value = true;
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: getVerticalSize(9),
                                  horizontal: getHorizontalSize(5)),
                              child: Container(
                                height: controller.isNewDealer.value == true
                                    ? Get.height * 0.07
                                    : Get.height * 0.05,
                                width: controller.isNewDealer.value == true
                                    ? Get.width * 0.50
                                    : Get.width * 0.35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // color: KColors.orange
                                    color: KColors.redColor.withOpacity(0.17)),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getHorizontalSize(14)),
                                    child: Center(
                                      child: AppText(
                                        text: "NEW DEALER",
                                        fontSize:
                                            controller.isNewDealer.value == true
                                                ? 17
                                                : 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     controller.isNewDealer.value = true;
                          //   },
                          //   child: Card(
                          //     color: controller.isNewDealer.value == true
                          //         ? AppColor.blackColor
                          //         : AppColor.blackColor.withOpacity(0.5),
                          //     child: Padding(
                          //       padding: controller.isNewDealer.value == true
                          //           ? const EdgeInsets.all(10.0)
                          //           : const EdgeInsets.all(8.0),
                          //       child: AppText(
                          //         text: "NEW DEALER",
                          //         color: AppColor.whiteColor,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          GestureDetector(
                            onTap: () async {
                              controller.isNewDealer.value = false;
                              controller.getUSersList();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: getVerticalSize(9),
                                  horizontal: getHorizontalSize(5)),
                              child: Container(
                                height: controller.isNewDealer.value == false
                                    ? Get.height * 0.07
                                    : Get.height * 0.05,
                                width: controller.isNewDealer.value == false
                                    ? Get.width * 0.50
                                    : Get.width * 0.35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // color: KColors.orange
                                    color: KColors.redColor.withOpacity(0.17)),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getHorizontalSize(14)),
                                    child: Center(
                                      child: AppText(
                                        text: "OLD DEALER",
                                        fontSize:
                                            controller.isNewDealer.value ==
                                                    false
                                                ? 17
                                                : 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     controller.isNewDealer.value = false;
                          //     controller.getUSersList();
                          //   },
                          //   child: Card(
                          //     color: controller.isNewDealer.value == true
                          //         ? AppColor.blackColor.withOpacity(0.5)
                          //         : AppColor.blackColor,
                          //     child: Padding(
                          //       padding: controller.isNewDealer.value == true
                          //           ? const EdgeInsets.all(8.0)
                          //           : const EdgeInsets.all(10.0),
                          //       child: AppText(
                          //         text: "OLD DEALER",
                          //         color: AppColor.whiteColor,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      controller.isNewDealer.value
                          ? SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: DropDown(),
                            ),
                      getheight(context, 0.020),
                      Visibility(
                        visible: controller.isNewDealer.value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getHorizontalSize(5)),
                          child: AppText(
                            text: "Enter Name",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.isNewDealer.value,
                        child: SizedBox(
                          height: getVerticalSize(80),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomFormField(
                              hint: "Enter Dealer Name",
                              controller: controller.dealerNameController,
                              inputType: TextInputType.name,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            AppText(
                              text: "OnBoard Count:",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            getWidth(context, 0.10),
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: CustomFormField(
                                // inputFormator: [],
                                controller: controller.driverCountController,
                                inputType: TextInputType.number,
                                maxLength: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            AppText(
                              text: "Battery Count:",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            getWidth(context, 0.13),
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: CustomFormField(
                                controller: controller.batteryCountController,
                                inputType: TextInputType.number,
                                maxLength: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            AppText(
                              text: "Charger Count:",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            getWidth(context, 0.12),
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: CustomFormField(
                                controller: controller.chargerCountController,
                                inputType: TextInputType.number,
                                maxLength: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppText(
                          text: "Wiring & Meter:",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex: 1,
                            child: RadioListTile(
                                title: AppText(
                                  text: "OK",
                                ),
                                value: "ok",
                                groupValue: controller.radioButton.value,
                                onChanged: (e) {
                                  print("This is value of eq");
                                  print(e);
                                  controller.radioButton.value = e.toString();
                                }),
                          ),
                          Flexible(
                            flex: 1,
                            child: RadioListTile(
                                title: AppText(
                                  text: "Not Ok",
                                ),
                                value: "notok",
                                groupValue: controller.radioButton.value,
                                onChanged: (e) {
                                  print("This is value of e");
                                  print(e);
                                  controller.radioButton.value = e.toString();
                                }),
                          ),
                        ],
                      ),

                      // Container(
                      //   padding: EdgeInsets.all(20),
                      //   child: Row(
                      //     children: [
                      //       RadioListTile(
                      //           title: AppText(
                      //             text: "OK",
                      //           ),
                      //           value: "ok",
                      //           groupValue: controller.radioButton.value,
                      //           onChanged: (e) =>
                      //               controller.radioButton.value = e.toString()),
                      //       RadioListTile(
                      //           title: AppText(
                      //             text: "NOT OK",
                      //           ),
                      //           value: "not ok",
                      //           groupValue: controller.radioButton.value,
                      //           onChanged: (e) =>
                      //               controller.radioButton.value = e.toString()),
                      //     ],
                      //   ),
                      // )
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppText(
                          text: "Upload an Image",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      controller.fileSelectedWidgetForBattery(context),
                      getheight(context, 0.020),
                      // GestureDetector(
                      //   onTap: () {
                      //     if (controller.driverCountController.text.isEmpty ||
                      //         controller.batteryCountController.text.isEmpty ||
                      //         controller.chargerCountController.text.isEmpty ||
                      //         controller.radioButton.value.isEmpty ||
                      //         controller
                      //             .selectedImagePathinBattery.value.isEmpty) {
                      //       customeToast("Please Enter All Fields");
                      //     } else {
                      //       controller.getDealerSurveys();
                      //       Get.back();
                      //       controller.dealerNameController.clear();
                      //       controller.driverCountController.clear();
                      //       controller.batteryCountController.clear();
                      //       controller.chargerCountController.clear();
                      //       controller.radioButton.value = "";
                      //       controller.selectedImagePathinBattery.value = "";
                      //       controller.pathNameforBattery.value = "";
                      //     }
                      //   },
                      //   child: Center(
                      //     child: Card(
                      //       color: AppColor.blackColor,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(12.0),
                      //         child: AppText(
                      //           fontSize: 15,
                      //           text: "Submit",
                      //           color: AppColor.whiteColor,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          if (controller.driverCountController.text.isEmpty ||
                              controller.batteryCountController.text.isEmpty ||
                              controller.chargerCountController.text.isEmpty ||
                              controller.radioButton.value.isEmpty ||
                              controller
                                  .selectedImagePathinBattery.value.isEmpty) {
                            customeToast("Please Enter All Fields");
                          } else {
                            controller.getDealerSurveys();
                            Get.back();
                            controller.dealerNameController.clear();
                            controller.driverCountController.clear();
                            controller.batteryCountController.clear();
                            controller.chargerCountController.clear();
                            controller.radioButton.value = "";
                            controller.selectedImagePathinBattery.value = "";
                            controller.pathNameforBattery.value = "";
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getVerticalSize(9),
                              horizontal: getHorizontalSize(5)),
                          child: Center(
                            child: Container(
                              height: Get.height * 0.07,
                              width: Get.width * 0.65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: KColors.orange
                                  color: KColors.redColor.withOpacity(0.17)),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(14)),
                                  child: Center(
                                    child: AppText(
                                      text: "SUBMIT",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
