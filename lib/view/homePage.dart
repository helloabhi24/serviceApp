import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:service/constant/constant.dart';
import 'package:service/constant/sizeHelper.dart';
import 'package:service/controllers.dart/getBatteryController.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/localStorage/localStorage.dart';
import 'package:service/utils/colors.dart';
import 'package:service/utils/customAssetsImage.dart';
import 'package:service/utils/customText.dart';
import 'package:service/widgets/homepageWidget.dart';
import '../controllers.dart/batteryDetailPageController.dart';
import '../controllers.dart/locationDetailsController.dart';
import '../utils/showDialouge.dart';
import 'batteryLocationPage.dart';
import 'chatPage.dart';
import 'googleRoutePage.dart';
import 'newConnectPage.dart';

class Homepage extends GetView<HomepageController> {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    LocalStorageController localStorageController = Get.find();
    GetDriverConnectController _getDriverConnectController = Get.find();
    // LocationAccessController locationAccessController = Get.find();
    // BatteryDetailpageController batteryDetailpageController = Get.find();
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColor.blackColor,
            onPressed: () {
              Get.to(const ChatsWithPerson());
            },
            child: Icon(Icons.chat),
          ),
          appBar: HomePageWidget.customeAppbar(context),
          drawer: Drawer(
            child: Column(
              children: [
                DrawerHeader(
                    decoration: const BoxDecoration(color: KColors.red),
                    child: ListView(
                      children: [
                        localStorageController.userImage.value.isEmpty
                            ? CircleAvatar(
                                child: Icon(Icons.person),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://admin.switchxenergy.com/uploads/user_service/${localStorageController.userImage.value}"))),
                                height: 60,
                                width: 60,
                              ),
                        height10,
                        Align(
                            alignment: Alignment.center,
                            child: AppText(
                              text: localStorageController.userName.value,
                              color: KColors.white,
                            )),
                        height10,
                        Align(
                            alignment: Alignment.center,
                            child: AppText(
                              text: localStorageController.userEmail.value,
                              color: KColors.white,
                            ))
                      ],
                    )),
                ListTile(
                  onTap: () {
                    showMyDialog(context);
                  },
                  title: const AppText(
                      text: "Logout",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: KColors.persistentBlack),
                  trailing:
                      const Icon(Icons.logout, color: KColors.persistentBlack),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 8,
                    // tileColor: KColors.red.withOpacity(0.1),
                    // color: KColors.red.withOpacity(0.4),
                    color: KColors.lightRedColor,

                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    // onTap: () {
                    //   viewDealerDetails(context, index);
                    // },
                    // leading: const Icon(
                    //   Icons.person,
                    //   color: KColors.persistentBlack,
                    // ),
                    // // trailing: const Icon(
                    // //   Icons.arrow_forward_ios,
                    // //   size: 13,
                    // // ),
                    // title: AppText(
                    //   text: controller.getdealerList[index].name!,
                    //   fontSize: 17.sp,
                    //   fontWeight: FontWeight.w600,
                    // ),
                    child: Column(
                      children: [
                        height8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.person,
                              color: KColors.persistentBlack,
                            ),
                            width2,
                            AppText(
                              // text:
                              //     controller.getdealerList[index].name!,
                              text: localStorageController.userName.value,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: "SERVICE USER ID",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  AppText(
                                    // text: homepageController
                                    //     .getdealerList[index].dealerId!,
                                    text: localStorageController
                                        .userServiceId.value,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              height5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: "NAME",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  AppText(
                                    // text: homepageController
                                    //     .getdealerList[index].name!,
                                    text: localStorageController.userName.value,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              height5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: "EMAIL ID",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  AppText(
                                    // text: homepageController
                                    //     .getdealerList[index].email!,
                                    text:
                                        localStorageController.userEmail.value,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              height5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: "PHONE NUMBER",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  AppText(
                                    // text: homepageController
                                    //     .getdealerList[index].phone!,
                                    text:
                                        localStorageController.userPhone.value,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              height5,
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     AppText(
                              //       text: "SERVICE PRICE",
                              //       fontSize: 15.sp,
                              //       fontWeight: FontWeight.w700,
                              //     ),
                              //     AppText(
                              //       // text: homepageController
                              //       //     .getdealerList[index]
                              //       //     .securityPrice!,
                              //       text: localStorageController
                              //           .userSecurityPrice.value,
                              //       fontSize: 15.sp,
                              //       fontWeight: FontWeight.w500,
                              //     ),
                              //   ],
                              // ),
                              // height5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: "ONLINE",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  AppText(
                                    // text: homepageController
                                    //     .getdealerList[index].isOnline!,
                                    text: localStorageController
                                        .userOnlineStatus.value,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              height5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: "ZONE",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  AppText(
                                    // text: homepageController
                                    //     .getdealerList[index].dealerId!,
                                    text: localStorageController.userZone.value,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              height5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: "ADDRESS",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Expanded(
                                    child: AppText(
                                      // text: homepageController
                                      //     .getdealerList[index]
                                      //     .parmanentAddress!,
                                      text: localStorageController
                                          .userPermanentAddress.value,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      // textOverflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Obx(
                //   () => SizedBox(
                //     height: Get.height * 0.64,
                //     child: ListView.builder(
                //       shrinkWrap: true,
                //       itemBuilder: (context, index) {
                //         return Padding(
                //           padding: const EdgeInsets.all(5.0),
                //           child: Card(
                //             elevation: 8,
                //             // tileColor: KColors.red.withOpacity(0.1),
                //             // color: KColors.red.withOpacity(0.4),
                //             color: KColors.lightRedColor,

                //             shape: const RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.only(
                //                     topLeft: Radius.circular(20),
                //                     topRight: Radius.circular(20),
                //                     bottomRight: Radius.circular(20),
                //                     bottomLeft: Radius.circular(20))),
                //             // onTap: () {
                //             //   viewDealerDetails(context, index);
                //             // },
                //             // leading: const Icon(
                //             //   Icons.person,
                //             //   color: KColors.persistentBlack,
                //             // ),
                //             // // trailing: const Icon(
                //             // //   Icons.arrow_forward_ios,
                //             // //   size: 13,
                //             // // ),
                //             // title: AppText(
                //             //   text: controller.getdealerList[index].name!,
                //             //   fontSize: 17.sp,
                //             //   fontWeight: FontWeight.w600,
                //             // ),
                //             child: Column(
                //               children: [
                //                 height5,
                //                 Row(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: [
                //                     const Icon(
                //                       Icons.person,
                //                       color: KColors.persistentBlack,
                //                     ),
                //                     width2,
                //                     AppText(
                //                       // text:
                //                       //     controller.getdealerList[index].name!,
                //                       text:
                //                           localStorageController.userName.value,
                //                       fontSize: 17.sp,
                //                       fontWeight: FontWeight.w600,
                //                     )
                //                   ],
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.all(15.0),
                //                   child: Column(
                //                     children: [
                //                       Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           AppText(
                //                             text: "DEALER ID",
                //                             fontSize: 15.sp,
                //                             fontWeight: FontWeight.w700,
                //                           ),
                //                           AppText(
                //                             // text: homepageController
                //                             //     .getdealerList[index].dealerId!,
                //                             text: localStorageController
                //                                 .userToken.value,
                //                             fontSize: 15.sp,
                //                             fontWeight: FontWeight.w500,
                //                           ),
                //                         ],
                //                       ),
                //                       height5,
                //                       Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           AppText(
                //                             text: "NAME",
                //                             fontSize: 15.sp,
                //                             fontWeight: FontWeight.w700,
                //                           ),
                //                           AppText(
                //                             // text: homepageController
                //                             //     .getdealerList[index].name!,
                //                             text: localStorageController
                //                                 .userName.value,
                //                             fontSize: 15.sp,
                //                             fontWeight: FontWeight.w500,
                //                           ),
                //                         ],
                //                       ),
                //                       height5,
                //                       Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           AppText(
                //                             text: "EMAIL ID",
                //                             fontSize: 15.sp,
                //                             fontWeight: FontWeight.w700,
                //                           ),
                //                           AppText(
                //                             // text: homepageController
                //                             //     .getdealerList[index].email!,
                //                             text: localStorageController
                //                                 .userEmail.value,
                //                             fontSize: 15.sp,
                //                             fontWeight: FontWeight.w500,
                //                           ),
                //                         ],
                //                       ),
                //                       height5,
                //                       Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           AppText(
                //                             text: "PHONE NUMBER",
                //                             fontSize: 15.sp,
                //                             fontWeight: FontWeight.w700,
                //                           ),
                //                           AppText(
                //                             // text: homepageController
                //                             //     .getdealerList[index].phone!,
                //                             text: localStorageController
                //                                 .userPhone.value,
                //                             fontSize: 15.sp,
                //                             fontWeight: FontWeight.w500,
                //                           ),
                //                         ],
                //                       ),
                //                       height5,
                //                       Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           AppText(
                //                             text: "SERVICE PRICE",
                //                             fontSize: 15.sp,
                //                             fontWeight: FontWeight.w700,
                //                           ),
                //                           AppText(
                //                             // text: homepageController
                //                             //     .getdealerList[index]
                //                             //     .securityPrice!,
                //                             text: localStorageController
                //                                 .userSecurityPrice.value,
                //                             fontSize: 15.sp,
                //                             fontWeight: FontWeight.w500,
                //                           ),
                //                         ],
                //                       ),
                //                       height5,
                //                       Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           AppText(
                //                             text: "ONLINE",
                //                             fontSize: 15.sp,
                //                             fontWeight: FontWeight.w700,
                //                           ),
                //                           AppText(
                //                             // text: homepageController
                //                             //     .getdealerList[index].isOnline!,
                //                             text: localStorageController
                //                                 .userOnlineStatus.value,
                //                             fontSize: 15.sp,
                //                             fontWeight: FontWeight.w500,
                //                           ),
                //                         ],
                //                       ),
                //                       height5,
                //                       Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           AppText(
                //                             text: "ADDRESS",
                //                             fontSize: 15.sp,
                //                             fontWeight: FontWeight.w700,
                //                           ),
                //                           Expanded(
                //                             child: AppText(
                //                               // text: homepageController
                //                               //     .getdealerList[index]
                //                               //     .parmanentAddress!,
                //                               text: localStorageController
                //                                   .userPermanentAddress.value,
                //                               fontSize: 15.sp,
                //                               fontWeight: FontWeight.w500,
                //                               // textOverflow: TextOverflow.ellipsis,
                //                               textAlign: TextAlign.right,
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //         );
                //       },
                //       itemCount: controller.getdealerList.length,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getHorizontalSize(10),
                vertical: getVerticalSize(10)),
            child: RefreshIndicator(
              onRefresh: () async {
                await localStorageController.getToken();

                await controller.userAttendence();
                await controller.getDay();
                controller.getAllDealerList();
                // homepageController.statusOnline("1");
                if (controller.attendenceStatus.value == false) {
                  controller.statusOnline("1");
                }
                await controller.serviceReport();
                controller.getUserList();
                await controller.getAllDealerList();
                await controller.getDriverdetail();
                // getLocation();
                // await determinePosition();
                // await getLocationFrequently();
              },
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: SizedBox(
                  height: Get.height * 0.875,
                  child: Column(
                    children: [
                      height13,
                      const UserDetail(),
                      getheight(context, 0.012),
                      const UserActivationPage(),
                      getheight(context, 0.020),
                      controller.attendenceStatus.value == true
                          ? AppText(
                              text: "Please Mark Your Attendance",
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColor.redColor,
                            )
                          : SizedBox.shrink(),
                      height13,
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getVerticalSize(5),
                              horizontal: getHorizontalSize(20)),
                          child: SizedBox(
                            child: AnimationLimiter(
                              child: GridView.builder(
                                physics: BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                addRepaintBoundaries: true,
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: Get.height * 0.14,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 23.0.w,
                                  mainAxisSpacing: 23.h,
                                ),
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredGrid(
                                      columnCount: 2,
                                      duration: Duration(milliseconds: 3000),
                                      position: index,
                                      child: SlideAnimation(
                                          child: FadeInAnimation(
                                              child: GestureDetector(
                                        onTap: () async {
                                          // await controller.getDealerList("");
                                          // await controller.serviceReport();

                                          // index == 2
                                          //     ? popup(context)
                                          //     :
                                          Get.to(controller.menuList[index]
                                              ["page"]);
                                          // index == 0 ? Get.to(const StationsPage()) : null;
                                          if (index == 0 ||
                                              index == 1 ||
                                              index == 3) {
                                            await controller.getDealerList("");
                                            await controller.serviceReport();
                                            Get.to(controller.menuList[index]
                                                ["page"]);
                                          }
                                          if (index == 5) {
                                            await _getDriverConnectController
                                                .getDriverConnect();
                                          }
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: Get.width * 0.30,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: Offset(2, 2),
                                                    color: Colors.grey
                                                        .withOpacity(0.6),
                                                    blurRadius: 10.0,
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: KColors.white),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  controller.menuList[index]
                                                      ["title"]!,
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                getheight(context, 0.008),
                                                CustomAssetsImage(
                                                    imagePath: controller
                                                            .menuList[index]
                                                        ["image"]!,
                                                    height: 30.h)
                                              ],
                                            )),
                                      ))));
                                },
                                itemCount: controller.menuList.length,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await controller.getUSersList();
                          Get.to(() => NewConncetPage());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getVerticalSize(9),
                              horizontal: getHorizontalSize(5)),
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
                                    text: "New Connect",
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
