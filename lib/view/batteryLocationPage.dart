import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service/constant/constant.dart';
import 'package:service/utils/textExtension.dart';
import '../constant/sizeHelper.dart';
import '../controllers.dart/batteryDetailPageController.dart';
import '../utils/customAssetsImage.dart';

class BatteryLocationPage extends GetView<BatteryDetailpageController> {
  const BatteryLocationPage({super.key});
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
              Expanded(
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: Get.height * 0.20,
                  width: Get.width,
                  child: GoogleMap(
                    circles: {
                      Circle(
                          circleId: const CircleId("1"),
                          center:
                              // LatLng(28.5799519, 77.319567),
                              LatLng(controller.latitude.value,
                                  controller.longitude.value),
                          radius: 200,
                          strokeWidth: 2,
                          strokeColor: KColors.blue.withOpacity(0.2),
                          fillColor: KColors.blue.withOpacity(0.3)),
                    },
                    // onMapCreated: (controlle) {
                    //   mapController = controlle;
                    // },
                    markers: {
                      Marker(
                          markerId: const MarkerId("1"),
                          position:
                              // LatLng(28.5799519, 77.319567),
                              LatLng(controller.latitude.value,
                                  controller.longitude.value),
                          infoWindow: InfoWindow(
                              title:
                                  "Battery ID - ${controller.batterId.toString()}"
                              // "${Get.arguments["batteryId"]}"
                              ),
                          icon: BitmapDescriptor.defaultMarker)
                    },
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target:
                            // LatLng(28.5799519, 77.319567),
                            LatLng(controller.latitude.value,
                                controller.longitude.value),
                        zoom: 15),
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
