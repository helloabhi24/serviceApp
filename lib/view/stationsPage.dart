import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:service/constant/constant.dart';
import 'package:service/controllers.dart/batteryDetailPageController.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/utils/customAssetsImage.dart';
import 'package:service/utils/customText.dart';

import '../utils/customToast.dart';

class StationsPage extends GetView<HomepageController> {
  const StationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    BatteryDetailpageController batteryDetailpageController =
        Get.put(BatteryDetailpageController());
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: KColors.persistentBlack,
          title: const AppText(text: "Stations", color: KColors.white),
          elevation: 0,
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
                elevation: 1,
                child: ExpansionTile(
                  leading: AppText(
                    text: "${index + 1}",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  title: AppText(
                    text: controller.dealerList[index].name,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    ...Iterable.generate(
                            controller.dealerList[index].battery.length)
                        .map((e) => Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () async {
                                  await batteryDetailpageController
                                      .fetchAllBattriesData(controller
                                          .dealerList[index]
                                          .battery[e]
                                          .batteryId)
                                      .whenComplete(() {
                                    if (batteryDetailpageController
                                            .batteryData.value !=
                                        "This Battery is not assigned to you") {
                                      Get.toNamed("/batterydetailpage",
                                          arguments: {
                                            "batteryId": controller
                                                .dealerList[index]
                                                .battery[e]
                                                .batteryId
                                          });
                                    } else {
                                      customeToast(
                                          "this battery is under process");
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      CustomAssetsImage(
                                        imagePath: "assets/images/battery.png",
                                        height: Get.height * 0.03,
                                      ),
                                      AppText(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          text: controller.dealerList[index]
                                              .battery[e].batteryId),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                  ],
                ));
          },
          itemCount: controller.dealerList.length,
        ),
      ),
    );
  }
}
