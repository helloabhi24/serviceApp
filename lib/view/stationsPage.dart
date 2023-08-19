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
import '../utils/constant.dart';
import '../utils/customToast.dart';
import '../widgets/homepageWidget.dart';
import 'batteryLocationPage.dart';
import 'dealerDetailsPages.dart';

class StationsPage extends GetView<BatteryDetailpageController> {
  const StationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    HomepageController homepageController = Get.find();
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          controller.searchController.clear();
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBarWidget.customeAppbar(context),
          //  AppBar(
          //   centerTitle: true,
          //   backgroundColor: KColors.persistentBlack,
          //   title: const AppText(text: "Stations", color: KColors.white),
          //   elevation: 0,
          // ),
          body: Column(
            children: [
              SizedBox(
                height: getVerticalSize(20),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  textCapitalization: TextCapitalization.characters,
                  controller: controller.searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: getVerticalSize(10),
                        horizontal: getHorizontalSize(10)),
                    hintText: "Search",
                    hintStyle: TextStyle(
                        color: KColors.persistentBlack, fontSize: 15.sp),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        homepageController
                            .getDealerList(controller.searchController.text);
                        // controller.fetchBattriesLocationData(
                        //     controller.searchController.text);
                        // if (controller.batterId.isEmpty == false) {
                        //   Future.delayed(const Duration(milliseconds: 1000), () {
                        //     Get.to(BatteryLocationPage());
                        //   });
                        // } else {
                        //   customeToast("This battery is not assign to u.");
                        // }
                        // Get.to(BatteryLocationPage());
                      },
                      child: const Icon(
                        Icons.search,
                        color: KColors.persistentBlack,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                          color: KColors.persistentBlack, width: .4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                          color: KColors.persistentBlack, width: .4),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(color: Colors.red, width: .4),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(color: Colors.black, width: .4),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getVerticalSize(700),
                child: AnimationLimiter(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        delay: Duration(milliseconds: 200),
                        position: index,
                        child: SlideAnimation(
                          verticalOffset: -250,
                          child: ScaleAnimation(
                            duration: Duration(milliseconds: 3000),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 10, right: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25),
                                      bottomLeft: Radius.circular(25)),
                                  color: KColors.red.withOpacity(0.17),
                                ),
                                child: GestureDetector(
                                  onTap: () => Get.to(() => DealerDetailsPage(),
                                      transition: Transition.fadeIn,
                                      arguments: index),
                                  child: ListTile(
                                    // leading: AppText(
                                    //   text: "${index + 1}",
                                    //   fontSize: 18.sp,
                                    //   fontWeight: FontWeight.w600,
                                    // ),
                                    leading: Icon(Icons.person),
                                    title: AppText(
                                      text: homepageController
                                                  .dealerList[index].name ==
                                              null
                                          ? "null"
                                          : homepageController
                                              .dealerList[index].name!,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    trailing: GestureDetector(
                                        onTap: () {
                                          print(
                                              "this is value of index in home");
                                          print(index);
                                          Get.to(() => DealerDetailsPage(),
                                              arguments: index);
                                        },
                                        child: Icon(Icons.arrow_forward)),
                                    // children: [
                                    //   ...Iterable.generate(homepageController
                                    //           .dealerList[index].battery!.length)
                                    //       .map((e) => Align(
                                    //             alignment: Alignment.centerLeft,
                                    //             child: GestureDetector(
                                    //               onTap: () async {
                                    //                 await controller
                                    //                     .fetchAllBattriesData(
                                    //                         homepageController
                                    //                             .dealerList[index]
                                    //                             .battery![e]
                                    //                             .batteryId!)
                                    //                     .whenComplete(() {
                                    //                   if (controller
                                    //                           .batteryData.value !=
                                    //                       Constant().assign) {
                                    //                     Get.toNamed(
                                    //                         "/batterydetailpage",
                                    //                         arguments: {
                                    //                           "batteryId":
                                    //                               homepageController
                                    //                                   .dealerList[
                                    //                                       index]
                                    //                                   .battery![e]
                                    //                                   .batteryId
                                    //                         });
                                    //                   } else {
                                    //                     customeToast(
                                    //                         Constant().toastText);
                                    //                   }
                                    //                 });
                                    //               },
                                    //               child: Padding(
                                    //                 padding:
                                    //                     const EdgeInsets.all(10.0),
                                    //                 child: Row(
                                    //                   children: [
                                    //                     CustomAssetsImage(
                                    //                       imagePath:
                                    //                           Constant().battery,
                                    //                       height: Get.height * 0.03,
                                    //                     ),
                                    //                     AppText(
                                    //                         fontSize: 16.sp,
                                    //                         fontWeight:
                                    //                             FontWeight.w600,
                                    //                         text: homepageController
                                    //                             .dealerList[index]
                                    //                             .battery![e]
                                    //                             .batteryId!),
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ))
                                    // ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: homepageController.dealerList.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
