import 'package:get/get.dart';
import 'package:service/utils/showLoadingIndicator.dart';

import '../apiService/apiRepo.dart';

class BatteryDetailpageController extends GetxController {
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

  Future fetchAllBattriesData(String bids) async {
    cellVoltageList.clear();
    print("batteryId");
    print(bids);
    try {
      showloadingIndicators();
      await ApiRepo().fetchPowerOfBatteries(bids).then((value) {
        batteryData.value = value[0]["Data"].toString();
        // print("baterry data ");
        // print(batteryData.value);
        soc.value = value[0]["soc"];
        pv.value = double.parse(value[0]["pv"].toString());
        cycle.value = value[0]["cycles"].toString();
        soh.value = value[0]["soh"].toString();
        latitude.value = value[0]["location"]["latitude"];
        longitude.value = value[0]["location"]["longitude"];
        bt.value = value[0]["temperature"][3];
        tempList.add(value[0]["temperature"]);
        cellVoltageList.add(value[0]["cellVoltages"]);

        print("socvalue");
        print(soc.value);
      });
    } catch (e) {
      print(e.toString());
    }
    hideLoading();
  }
}
