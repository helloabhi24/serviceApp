import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service/constant/constant.dart';
import 'package:service/utils/textExtension.dart';
import '../constant/sizeHelper.dart';
import '../controllers.dart/batteryDetailPageController.dart';
import '../utils/customAssetsImage.dart';
import '../utils/customText.dart';
import '../widgets/batteryDetailPage.dart';

class BatteryDetailPage extends GetView<BatteryDetailpageController> {
  const BatteryDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    // late GoogleMapController mapController;
    // controller.soc2.value = controller.soc.value * 0.7;

    print("socjjjjjj");
    print(controller.soc.value);
    // Get.arguments["batteryId"];
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: KColors.persistentBlack,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomAssetsImage(
                imagePath: "assets/images/HX.png",
                height: Get.height * 0.06,
              ),
              getWidth(context, 0.010),
              "SwitchX".f20w5(),
            ],
          ),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              getheight(context, 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Obx(
                        () => AppText(
                            text: "${controller.soc.value}%",
                            fontSize: 60.sp,
                            fontWeight: FontWeight.w600,
                            color: KColors.red),
                      ),
                      AppText(
                        text: "state of charge",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                  getWidth(context, 0.050),
                  const CustomBatteryIndicator()
                  // const Icon(
                  //   Icons.battery_charging_full,
                  //   color: AppColor.greenColor,
                  //   size: 100,
                  // )
                ],
              ),
              getheight(context, 0.010),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: getHorizontalSize(10)),
                height: Get.height * 0.07,
                width: Get.width,
                color: KColors.persistentBlack,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.motorcycle,
                      color: KColors.white,
                      size: 32.h,
                    ),
                    AppText(
                        text: "Distance Remaining",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: KColors.white),
                    AppText(
                        text: "${controller.soc2.value.toStringAsFixed(2)} km",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: KColors.white)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    tempWidget(
                        "assets/images/temp.png",
                        "${controller.bt.value.toString()}" " °C",
                        "Battery temperature",
                        40.h, () {
                      // showTempdialouges(context);
                    }),
                    tempWidget(
                        "assets/images/chargebat.png",
                        "${controller.pv.value / 1000} v".toString(),
                        "Battery Voltage",
                        45.h, () {
                      // showdialouges(context);
                    })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    tempWidget(
                        "assets/images/batcycle.png",
                        "${controller.cycle.value} cycle",
                        "Battery Cycles",
                        35.h,
                        () {}),
                    tempWidget(
                        "assets/images/bat.png",
                        "${controller.soh.value} %",
                        "State of health",
                        35.h,
                        () {})
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () => Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    height: Get.height * 0.20,
                    width: Get.width,
                    child: GoogleMap(
                      circles: {
                        Circle(
                            circleId: const CircleId("1"),
                            center: LatLng(controller.latitude.value,
                                controller.longitude.value),
                            radius: 200,
                            strokeWidth: 2,
                            strokeColor: KColors.blue.withOpacity(0.2),
                            fillColor: KColors.blue..withOpacity(0.3)),
                      },
                      // onMapCreated: (controlle) {
                      //   mapController = controlle;
                      // },
                      markers: {
                        Marker(
                            markerId: const MarkerId("1"),
                            position: LatLng(controller.latitude.value,
                                controller.longitude.value),
                            infoWindow: InfoWindow(
                                title: "BatteryId "
                                    "${Get.arguments["batteryId"]}"),
                            icon: BitmapDescriptor.defaultMarker)
                      },
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(controller.latitude.value,
                              controller.longitude.value),
                          zoom: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  tempWidget(
      String image, String temp, String batTemp, double size, Function ontap) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        height: Get.height * 0.20,
        width: Get.width * 0.43,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 12,
            color: Color.fromRGBO(0, 0, 0, 0.10),
          )
        ], borderRadius: BorderRadius.circular(15), color: KColors.white),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: getVerticalSize(25)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: KColors.white,
                child: CustomAssetsImage(
                  height: size,
                  imagePath: image,
                ),
              ),
              AppText(
                text: temp,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: KColors.red,
              ),
              AppText(
                text: batTemp,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: KColors.persistentBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
