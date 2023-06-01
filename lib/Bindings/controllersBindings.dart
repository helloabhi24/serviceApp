import 'package:get/get.dart';
import 'package:service/controllers.dart/batteryDetailPageController.dart';

import '../controllers.dart/homepageController.dart';

class GetXbindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageController>(() => HomepageController(), fenix: true);
    Get.lazyPut<BatteryDetailpageController>(
        () => BatteryDetailpageController(),
        fenix: false);
  }
}
