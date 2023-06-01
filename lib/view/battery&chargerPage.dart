import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/view/stationsPage.dart';
import 'package:service/utils/customAssetsImage.dart';
import 'package:service/utils/customText.dart';
import '../constant/constant.dart';
import '../constant/sizeHelper.dart';

class BatteryAndChargerPage extends GetView<HomepageController> {
  const BatteryAndChargerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColors.persistentBlack,
        centerTitle: true,
        title: const AppText(
          text: "BatteryAndChargerPage",
        ),
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
              mainAxisExtent: Get.height * 0.18,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 8.h,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  index == 0 ? Get.to(const StationsPage()) : null;
                },
                child: Container(
                    width: Get.width * 0.30,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(8),
                        color: KColors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.batteryAndChargerList[index]["title"]!,
                          style: TextStyle(
                              fontSize: 22.sp, fontWeight: FontWeight.w600),
                        ),
                        width10,
                        CustomAssetsImage(
                            imagePath: controller.batteryAndChargerList[index]
                                ["image"]!,
                            height: 40.h)
                      ],
                    )),
              );
            },
            itemCount: controller.batteryAndChargerList.length,
          ),
        ),
      ),
    );
  }
}
