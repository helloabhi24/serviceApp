import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/constant/constant.dart';
import 'package:service/controllers.dart/batteryDetailPageController.dart';

class CustomBatteryIndicator extends StatelessWidget {
  const CustomBatteryIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BatteryDetailpageController batteryDetailPageController = Get.find();
    return Obx(
      () => SizedBox(
        height: 80,
        width: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 10,
              decoration: const BoxDecoration(
                  color: KColors.persistentBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                    width: 40,
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: KColors.persistentBlack, width: 1.5),
                        borderRadius: BorderRadius.circular(5)),
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      height:
                          (70 * (batteryDetailPageController.soc.value / 100))
                              .clamp(0, 70),
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                          color: batteryDetailPageController.soc.value < 20
                              ? KColors.white
                              : KColors.green,
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(5))),
                    )),
                Icon(Icons.electric_bolt_rounded,
                    color: KColors.persistentBlack.withOpacity(0.6))
              ],
            )
          ],
        ),
      ),
    );
  }
}
