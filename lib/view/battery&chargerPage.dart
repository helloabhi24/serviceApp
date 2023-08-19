import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/utils/customAssetsImage.dart';
import 'package:service/utils/customText.dart';
import 'package:service/utils/textExtension.dart';
import '../constant/constant.dart';
import '../constant/sizeHelper.dart';
import '../utils/constant.dart';

class BatteryAndChargerPage extends GetView<HomepageController> {
  const BatteryAndChargerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: getVerticalSize(20), horizontal: getHorizontalSize(10)),
          child: SizedBox(
            height: Get.height * 0.40,
            child: GridView.builder(
              addRepaintBoundaries: true,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: Get.height * 0.15,
                crossAxisCount: 2,
                crossAxisSpacing: 23.0.w,
                mainAxisSpacing: 23.h,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    // await controller.getDealerList();
                    // index==2? batteryChargerProblem(context):null;
                    controller.userName.value = "";
                    controller.problemType.value = "";
                    controller.navigatetoPage(index);
                  },
                  child: Container(
                      width: Get.width * 0.30,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 2),
                              color: Colors.grey.withOpacity(0.6),
                              // color: Colors.grey,
                              blurRadius: 10.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8),
                          color: KColors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.batteryAndChargerList[index]["title"]!,
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                          getheight(context, 0.008),
                          CustomAssetsImage(
                              imagePath: controller.batteryAndChargerList[index]
                                  ["image"]!,
                              height: 30.h)
                        ],
                      )),
                );
              },
              itemCount: controller.batteryAndChargerList.length,
            ),
          ),
        ),
      ),
    );
  }
}
