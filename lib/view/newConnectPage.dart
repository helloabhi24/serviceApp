import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:intl/src/intl/date_format.dart';

class NewConncetPage extends GetView<HomepageController> {
  const NewConncetPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.lightRedColor,
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
                horizontal: getHorizontalSize(20)),
            child: Column(
              children: [
                getheight(context, 0.020),
                AppText(
                  text: "NEW CONNCETION",
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getheight(context, 0.020),
                    getheight(context, 0.020),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        controller.fileSelectedWidgetForPhoto(context)
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getHorizontalSize(5)),
                          child: AppText(
                            text: "NAME",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        RichText(
                            text: const TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ))),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getHorizontalSize(20),
                              vertical: getVerticalSize(3)),
                          child: SizedBox(
                            width: getHorizontalSize(260),
                            // height: 20,
                            child: TextFormField(
                              controller: controller.nameConnectionController,
                              decoration: new InputDecoration(
                                labelText: "Enter Name",
                                fillColor: Colors.white,
                                // border: new OutlineInputBorder(
                                //   borderRadius: new BorderRadius.circular(25.0),
                                //   borderSide: new BorderSide(),
                                // ),
                                //fillColor: Colors.green
                              ),
                              validator: (val) {
                                // if (val.length == 0) {
                                //   return "Email cannot be empty";
                                // } else {
                                //   return null;
                                // }
                              },
                              keyboardType: TextInputType.name,
                              // style: new TextStyle(
                              //   fontFamily: "Poppins",
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    getheight(context, 0.020),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getHorizontalSize(5)),
                          child: AppText(
                            text: "PHONE NO.",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        RichText(
                            text: const TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ))),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getHorizontalSize(20),
                              vertical: getVerticalSize(3)),
                          child: SizedBox(
                            width: getHorizontalSize(200),
                            // height: 20,
                            child: TextFormField(
                              controller: controller.phoneConnectionController,
                              decoration: new InputDecoration(
                                labelText: "Phone No.",
                                fillColor: Colors.white,
                                // border: new OutlineInputBorder(
                                //   borderRadius: new BorderRadius.circular(25.0),
                                //   borderSide: new BorderSide(),
                                // ),
                                //fillColor: Colors.green
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (val) {
                                // if (val!.length == 0) {
                                //   return "Email cannot be empty";
                                // } else {
                                //   return null;
                                // }
                              },
                              keyboardType: TextInputType.phone,
                              // style: new TextStyle(
                              //   fontFamily: "Poppins",
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    getheight(context, 0.020),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getHorizontalSize(5)),
                          child: AppText(
                            text: "DATE OF ONBOARD",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        RichText(
                            text: const TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ))),
                        Obx(
                          () => GestureDetector(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  //firstDate: DateTime(2015, 8),
                                  firstDate: DateTime(2015)
                                      .subtract(const Duration(days: 0)),
                                  lastDate: DateTime(2029));
                              if (picked != null &&
                                  // ignore: unrelated_type_equality_checks
                                  picked !=
                                      controller.selectedDateONBoarding.value) {
                                String formattedDate =
                                    DateFormat('MM/dd/yyyy').format(picked);
                                controller.selectedDateONBoarding.value =
                                    formattedDate.toString();
                                controller.onBoardingDate.value =
                                    "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}"
                                        .split("00:00:00.000")
                                        .first;
                              }
                              print("this is data you picked");
                              print(controller.onBoardingDate.value);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: Get.height * 0.06,
                                width: Get.width * 0.40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: KColors.background
                                            .withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getVerticalSize(10),
                                      horizontal: getHorizontalSize(10)),
                                  child: AppText(
                                    textAlign: TextAlign.center,
                                    text: controller.selectedDateONBoarding
                                            .value.isEmpty
                                        ? "MM/DD/YYYY"
                                        : controller
                                            .selectedDateONBoarding.value
                                            .split("00:00:00.000")
                                            .first,
                                    color: KColors.background.withOpacity(0.9),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getHorizontalSize(5)),
                          child: AppText(
                            text: "USER LIST",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        RichText(
                            text: const TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ))),
                        DropDownForNewConnection(),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getHorizontalSize(5)),
                          child: AppText(
                            text: "SECURITY",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        RichText(
                            text: const TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ))),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getHorizontalSize(20),
                              vertical: getVerticalSize(3)),
                          child: SizedBox(
                            width: getHorizontalSize(200),
                            // height: 20,
                            child: TextFormField(
                              controller:
                                  controller.securityConnectionController,
                              decoration: new InputDecoration(
                                labelText: "Security",
                                fillColor: Colors.white,
                                // border: new OutlineInputBorder(
                                //   borderRadius: new BorderRadius.circular(25.0),
                                //   borderSide: new BorderSide(),
                                // ),
                                //fillColor: Colors.green
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(8),
                              ],
                              validator: (val) {
                                // if (val.length == 0) {
                                //   return "Email cannot be empty";
                                // } else {
                                //   return null;
                                // }
                              },
                              keyboardType: TextInputType.number,
                              // style: new TextStyle(
                              //   fontFamily: "Poppins",
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getHorizontalSize(5)),
                          child: AppText(
                            text: "AADHAR CARD",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        RichText(
                            text: const TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ))),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getHorizontalSize(20),
                              vertical: getVerticalSize(3)),
                          child: SizedBox(
                            width: getHorizontalSize(200),
                            // height: 20,
                            child: TextFormField(
                              controller: controller.aadharConnectionController,
                              decoration: new InputDecoration(
                                labelText: "Aadhar No.",
                                fillColor: Colors.white,
                                // border: new OutlineInputBorder(
                                //   borderRadius: new BorderRadius.circular(25.0),
                                //   borderSide: new BorderSide(),
                                // ),
                                //fillColor: Colors.green
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(12),
                              ],
                              validator: (val) {
                                if (val!.length == 12) {
                                  return "Aadhar No.can't be empty";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              // style: new TextStyle(
                              //   fontFamily: "Poppins",
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // SizedBox(
                    //   height: getVerticalSize(80),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: CustomFormField(
                    //       hint: "Enter Dealer Name",
                    //       controller: controller.dealerNameController,
                    //       inputType: TextInputType.name,
                    //     ),
                    //   ),

                    getheight(context, 0.020),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getHorizontalSize(5)),
                          child: AppText(
                            text: "AADHAR CARD (Photo)",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        RichText(
                            text: const TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                )))
                      ],
                    ),

                    getheight(context, 0.005),
                    controller.fileSelectedWidgetForAadhar(context),
                    getheight(context, 0.020),

                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getHorizontalSize(5)),
                          child: AppText(
                            text: "R/C (Photo)",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        RichText(
                            text: const TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                )))
                      ],
                    ),
                    getheight(context, 0.005),
                    controller.fileSelectedWidgetForRc(context),
                    getheight(context, 0.020),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getHorizontalSize(5)),
                      child: AppText(
                        text: "ADDITIONAL DETAILS (Optional)",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    getheight(context, 0.005),
                    controller.fileSelectedWidgetForAdditional(context),
                    getheight(context, 0.020),

                    // getheight(context, 0.020),
                    // GestureDetector(
                    //   onTap: () {
                    //     if (controller.nameConnectionController.text.isEmpty ||
                    //         controller.phoneConnectionController.text.isEmpty ||
                    //         controller
                    //             .aadharConnectionController.text.isEmpty ||
                    //         controller.selectedDateONBoarding.value.isEmpty ||
                    //         controller
                    //             .selectedImagePathforAadhar.value.isEmpty ||
                    //         controller.selectedImagePathforRc.value.isEmpty ||
                    //         controller
                    //             .selectedImagePathforAadhar.value.isEmpty) {
                    //       customeToast("Please Enter All Fields");
                    //     } else {
                    //       controller.addDrivers();
                    //       Get.back();

                    //       controller.nameConnectionController.clear();
                    //       controller.phoneConnectionController.clear();
                    //       controller.aadharConnectionController.clear();
                    //       controller.securityConnectionController.clear();

                    //       controller.selectedDateONBoarding.value = "";
                    //       controller.selectedImagePathforAadhar.value = "";
                    //       controller.selectedImagePathforRc.value = "";
                    //       controller.selectedImagePathforAadhar.value = "";
                    //       controller.selectedImagePathforPhoto.value = "";
                    //       controller.pathNameforAadhar.value = "";
                    //       controller.pathNameforAddtional.value = "";
                    //       controller.pathNameforPhoto.value = "";
                    //       controller.pathNameforRc.value = "";
                    //     }
                    //   },
                    //   child: Center(
                    //     child: Card(
                    //       color: AppColor.blackColor,
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: AppText(
                    //           text: "Submit",
                    //           color: AppColor.whiteColor,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () async {
                        if (controller.nameConnectionController.text.isEmpty ||
                            controller.phoneConnectionController.text.isEmpty ||
                            controller
                                .aadharConnectionController.text.isEmpty ||
                            controller.selectedDateONBoarding.value.isEmpty ||
                            controller
                                .selectedImagePathforAadhar.value.isEmpty ||
                            controller.selectedImagePathforRc.value.isEmpty ||
                            controller
                                .selectedImagePathforAadhar.value.isEmpty) {
                          customeToast("Please Enter All Fields");
                        } else {
                          await controller.referForNewConnection();
                          await controller.addDrivers();
                          Get.back();

                          controller.nameConnectionController.clear();
                          controller.phoneConnectionController.clear();
                          controller.aadharConnectionController.clear();
                          controller.securityConnectionController.clear();

                          controller.selectedDateONBoarding.value = "";
                          controller.selectedImagePathforAadhar.value = "";
                          controller.selectedImagePathforRc.value = "";
                          controller.selectedImagePathforAadhar.value = "";
                          controller.selectedImagePathforPhoto.value = "";
                          controller.pathNameforAadhar.value = "";
                          controller.pathNameforAddtional.value = "";
                          controller.pathNameforPhoto.value = "";
                          controller.pathNameforRc.value = "";
                          controller.selectedImagePathforAddtional.value = "";
                          controller.pathNameforAddtional.value = "";
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
                                    text: "Submit",
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
    );
  }
}
