
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:service/constant/constant.dart';
import 'package:service/controllers.dart/batteryDetailPageController.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/utils/customAssetsImage.dart';
import 'package:service/utils/customText.dart';
import '../utils/constant.dart';
import '../utils/customToast.dart';

class StationsPage extends GetView<BatteryDetailpageController> {
  const StationsPage({super.key});
  @override
  Widget build(BuildContext context) {
   HomepageController homepageController =  Get.find();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: KColors.persistentBlack,
          title: const AppText(text: "Stations", color: KColors.white),
          elevation: 0,
        ),
        body: AnimationLimiter(
          child: ListView.builder(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(delay: Duration(milliseconds: 200),
                position: index,
                child: SlideAnimation(verticalOffset: -250,
                  child: ScaleAnimation(
                    duration: Duration(milliseconds: 3000),curve: Curves.fastLinearToSlowEaseIn,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(color: KColors.red.withOpacity(0.1),
                        child: ExpansionTile(
                          leading: AppText(
                            text: "${index + 1}",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          title: AppText(
                            text: homepageController.dealerList[index].name==null?"null":homepageController.dealerList[index].name!,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            ...Iterable.generate(
                                    homepageController.dealerList[index].battery!.length)
                                .map((e) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(
                                        onTap: () async {
                                          await controller
                                              .fetchAllBattriesData(homepageController
                                                  .dealerList[index]
                                                  .battery![e]
                                                  .batteryId!)
                                              .whenComplete(() {
                                            if (controller
                                                    .batteryData.value !=
                                              Constant().assign ) {
                                              Get.toNamed("/batterydetailpage",
                                                  arguments: {
                                                    "batteryId": homepageController
                                                        .dealerList[index]
                                                        .battery![e]
                                                        .batteryId
                                                  });
                                            } else {
                                              customeToast(Constant().toastText);
                                            }
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [                                     
                                              CustomAssetsImage(
                                                imagePath: Constant().battery,
                                                height: Get.height * 0.03,
                                              ),
                                              AppText(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                  text: homepageController.dealerList[index]
                                                      .battery![e].batteryId!),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                          ],
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
    );
  }
}
