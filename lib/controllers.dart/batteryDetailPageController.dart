import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/utils/customToast.dart';
import 'package:service/utils/showLoadingIndicator.dart';
import '../apiService/apiRepo.dart';
import '../view/batteryLocationPage.dart';

class BatteryDetailpageController extends GetxController {
  // RxInt a = 0.obs;
  RxBool isToggle = true.obs;
  RxBool isLoading = false.obs;
  RxInt soc = 0.obs;
  RxDouble pv = 0.0.obs;
  RxString cycle = "".obs;
  RxString soh = "".obs;
  RxInt bt = 0.obs;
  RxDouble soc2 = 0.0.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString status = "".obs;
  RxString batterId = "".obs;
  RxString batteryData = "".obs;
  RxList cellVoltageList = [].obs;
  RxList tempList = [].obs;

  late TextEditingController searchController;

  Future fetchAllBattriesData(String bids) async {
    cellVoltageList.clear();
    try {
      showloadingIndicators();
      await ApiRepo().fetchPowerOfBatteries(bids).then((value) {
        batterId.value = value[0]["Bid"];
        batteryData.value = value[0]["Data"].toString();
        soc.value = value[0]["soc"];
        pv.value = double.parse(value[0]["pv"].toString());
        cycle.value = value[0]["cycles"].toString();
        soh.value = value[0]["soh"].toString();
        latitude.value = value[0]["location"]["latitude"];
        longitude.value = value[0]["location"]["longitude"];
        bt.value = value[0]["temperature"][3];
        tempList.add(value[0]["temperature"]);
        cellVoltageList.add(value[0]["cellVoltages"]);
      });
    } catch (e) {
      print(e.toString());
    }
    hideLoading();
  }

  Future fetchBattriesLocationData(String bids) async {
    try {
      showloadingIndicators();
      await ApiRepo().fetchPowerOfBatteries(bids).then((value) {
        if (value[0]["Bid"] == bids && value[0]["Name"] == bids) {
          batterId.value = value[0]["Bid"];
          batteryData.value = value[0]["Data"].toString();
          soc.value = value[0]["soc"];
          pv.value = double.parse(value[0]["pv"].toString());
          cycle.value = value[0]["cycles"].toString();
          soh.value = value[0]["soh"].toString();
          latitude.value = value[0]["location"]["latitude"];
          longitude.value = value[0]["location"]["longitude"];
          bt.value = value[0]["temperature"][3];
          hideLoading();
          Get.to(() => BatteryLocationPage());
        } else {
          customeToast(value[0]["Data"]);
          hideLoading();
        }
        // tempList.add(value[0]["temperature"]);
        // cellVoltageList.add(value[0]["cellVoltages"]);
      });
    } catch (e) {
      print(e.toString());
    }
    // hideLoading();
  }

  @override
  void onInit() async {
    searchController = TextEditingController();
    super.onInit();
  }
}
