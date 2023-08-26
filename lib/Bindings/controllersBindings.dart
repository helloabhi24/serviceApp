import 'package:get/get.dart';
import 'package:service/controllers.dart/batteryDetailPageController.dart';
import 'package:service/controllers.dart/getBatteryController.dart';
import 'package:service/controllers.dart/singinppagecontroller.dart';
import 'package:service/localStorage/localStorage.dart';

import '../controllers.dart/homepageController.dart';
import '../controllers.dart/locationDetailsController.dart';

class GetXbindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageController>(() => HomepageController(), fenix: true);
    Get.lazyPut<BatteryDetailpageController>(
        () => BatteryDetailpageController(),
        fenix: true);
    Get.lazyPut<SinginpageController>(() => SinginpageController(),
        fenix: true);

    Get.lazyPut<LocalStorageController>(() => LocalStorageController(),
        fenix: true);

    Get.lazyPut<GetDriverConnectController>(() => GetDriverConnectController(),
        fenix: true);

    Get.lazyPut<LocationAccessController>(() => LocationAccessController(),
        fenix: true);

        Get.lazyPut<HomepageController>(() => HomepageController(),
        fenix: true);
  }
}
