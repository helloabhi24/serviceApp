import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:service/constant/constant.dart';
import 'package:service/controllers.dart/batteryDetailPageController.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/utils/customAssetsImage.dart';
import 'package:service/utils/customText.dart';
import '../constant/sizeHelper.dart';
import '../controllers.dart/getBatteryController.dart';
import '../utils/constant.dart';
import '../utils/customToast.dart';
import '../widgets/homepageWidget.dart';
import 'batteryLocationPage.dart';

class SwapBatteryHistoryPage extends GetView<GetDriverConnectController> {
  const SwapBatteryHistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    HomepageController homepageController = Get.find();
    return Obx(
      () => Scaffold(
          // backgroundColor: Colors.red[50],
          backgroundColor: Color.fromARGB(255, 245, 234, 235),
          resizeToAvoidBottomInset: false,
          appBar: AppBarWidget.customeAppbar(context),
          //  AppBar(
          //   centerTitle: true,
          //   backgroundColor: KColors.persistentBlack,
          //   title: const AppText(text: "Stations", color: KColors.white),
          //   elevation: 0,
          // ),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                getheight(context, 0.010),
                AppText(
                  text: "Swap",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  // color: KColors.white,
                ),
                getheight(context, 0.030),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: getHorizontalSize(10)),
                  height: Get.height * 0.05,
                  decoration: BoxDecoration(
                      // color: KColors.grey.withOpacity(0.5),
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppText(
                        text: "TOTAL SWAP",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        text: homepageController.swapBatteryList.length
                            .toString(),
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ],
                  ),
                ),
                getheight(context, 0.030),

                SizedBox(
                  height: homepageController.swapBatteryList.isEmpty
                      ? 0
                      : Get.height * 0.70,
                  // : Get.height,
                  width: Get.width,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index1) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            shadowColor: Colors.red[50],
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color.fromARGB(255, 238, 216, 215)),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            borderOnForeground: false,
                            color: Colors.red[50],
                            elevation: 8,
                            // height: Get.height * 0.38,
                            // margin: EdgeInsets.all(5),
                            // padding: EdgeInsets.all(4),
                            // decoration: BoxDecoration(
                            //     border: Border.all(color: KColors.lightGrey),
                            //     borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppText(
                                          text: "Date",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        AppText(
                                          text: homepageController
                                              .swapBatteryList[index1].createdOn
                                              .toString(),
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
                                          text: "Driver ID",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        AppText(
                                          text: homepageController
                                              .swapBatteryList[index1].driverId,
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
                                          text: "Battery One",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        AppText(
                                          text: homepageController
                                              .swapBatteryList[index1]
                                              .batteryOne,
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
                                          text: "Battery Two",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        AppText(
                                          text: homepageController
                                              .swapBatteryList[index1]
                                              .batteryTwo,
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
                                          text: "Price",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        AppText(
                                          text:
                                              "₹${homepageController.swapBatteryList[index1].price}",
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
                                          text: "Retrun Time",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        AppText(
                                          text: homepageController
                                              .swapBatteryList[index1]
                                              .returnTime,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: KColors.persistentBlack
                                              .withOpacity(0.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: homepageController.swapBatteryList.length,
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Card(
                //     shadowColor: Colors.red[50],
                //     shape: RoundedRectangleBorder(
                //       side:
                //           BorderSide(color: Color.fromARGB(255, 238, 216, 215)),
                //       borderRadius: BorderRadius.circular(20.0),
                //     ),
                //     borderOnForeground: false,
                //     color: Colors.red[50],
                //     elevation: 8,
                //     child: Padding(
                //       padding: const EdgeInsets.all(20.0),
                //       child: Column(
                //         children: [
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               AppText(
                //                 text: "Dealer ID",
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //               AppText(
                //                 // color: KColors.white,
                //                 text: homepageController
                //                     .dealerList[Get.arguments].dealerId,
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w400,
                //               ),
                //             ],
                //           ),
                //           getheight(context, 0.020),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               AppText(
                //                 // color: KColors.white,
                //                 text: "Name",
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //               AppText(
                //                 // color: KColors.white,
                //                 text: homepageController
                //                     .dealerList[Get.arguments].name,
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w400,
                //               ),
                //             ],
                //           ),
                //           getheight(context, 0.020),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               AppText(
                //                 // color: KColors.white,
                //                 text: "Email",
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //               AppText(
                //                 // color: KColors.white,
                //                 text: homepageController
                //                     .dealerList[Get.arguments].email,
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w400,
                //               ),
                //             ],
                //           ),
                //           getheight(context, 0.020),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               AppText(
                //                 // color: KColors.white,
                //                 text: "Phone Number",
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //               AppText(
                //                 // color: KColors.white,
                //                 text: homepageController
                //                     .dealerList[Get.arguments].phone,
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w400,
                //               ),
                //             ],
                //           ),
                //           getheight(context, 0.020),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               AppText(
                //                 // color: KColors.white,
                //                 text: "Service",
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //               AppText(
                //                 // color: KColors.white,
                //                 text: homepageController
                //                     .dealerList[Get.arguments].service,
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w400,
                //               ),
                //             ],
                //           ),
                //           getheight(context, 0.020),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               AppText(
                //                 // color: KColors.white,
                //                 text: "Security Price",
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //               AppText(
                //                 // color: KColors.white,
                //                 text: homepageController
                //                     .dealerList[Get.arguments].securityPrice,
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w400,
                //               ),
                //             ],
                //           ),
                //           getheight(context, 0.020),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               AppText(
                //                 // color: KColors.white,
                //                 text: "Online",
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //               AppText(
                //                 // color: KColors.white,
                //                 text: homepageController
                //                     .dealerList[Get.arguments].isOnline,
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w400,
                //               ),
                //             ],
                //           ),
                //           getheight(context, 0.020),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               AppText(
                //                 // color: KColors.white,
                //                 text: "Parmanent Address",
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //               Flexible(
                //                 child: AppText(
                //                   // color: KColors.white,
                //                   textAlign: TextAlign.right,
                //                   text: homepageController
                //                       .dealerList[Get.arguments]
                //                       .parmanentAddress,
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.w400,
                //                 ),
                //               ),
                //             ],
                //           ),
                //           getheight(context, 0.020),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               AppText(
                //                 // color: KColors.white,
                //                 text: "Switch Address",
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //               Flexible(
                //                 child: AppText(
                //                   // color: KColors.white,
                //                   textAlign: TextAlign.right,
                //                   text: homepageController
                //                       .dealerList[Get.arguments].switchAddress,
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.w400,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // getheight(context, 0.020),
                // ExpansionTile(
                //   title: AppText(
                //     // color: KColors.white,
                //     text: "Show Batteries",
                //   ),
                //   children: [
                //     ...Iterable.generate(homepageController
                //             .dealerList[Get.arguments].battery!.length)
                //         .map((e) => Align(
                //               alignment: Alignment.centerLeft,
                //               child: GestureDetector(
                //                 onTap: () async {
                //                   await controller
                //                       .fetchAllBattriesData(homepageController
                //                           .dealerList[Get.arguments]
                //                           .battery![e]
                //                           .batteryId!)
                //                       .whenComplete(() {
                //                     if (controller.batteryData.value !=
                //                         Constant().assign) {
                //                       Get.toNamed("/batterydetailpage",
                //                           arguments: {
                //                             "batteryId": homepageController
                //                                 .dealerList[Get.arguments]
                //                                 .battery![e]
                //                                 .batteryId
                //                           });
                //                     } else {
                //                       customeToast(Constant().toastText);
                //                     }
                //                   });
                //                 },
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(10.0),
                //                   child: Row(
                //                     children: [
                //                       CustomAssetsImage(
                //                         imagePath: Constant().battery,
                //                         height: Get.height * 0.03,
                //                       ),
                //                       AppText(
                //                           // color: KColors.white,
                //                           fontSize: 16.sp,
                //                           fontWeight: FontWeight.w600,
                //                           text: homepageController
                //                               .dealerList[Get.arguments]
                //                               .battery![e]
                //                               .batteryId!),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ))
                //   ],
                // )
              ],
            ),
          )),
    );
  }
}
