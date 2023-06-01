import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/view/stationsPage.dart';

import '../apiService/apiRepo.dart';
import '../model/dealerModel.dart';
import '../utils/showLoadingIndicator.dart';
import '../view/battery&chargerPage.dart';

class HomepageController extends GetxController {
  final signinformKey = GlobalKey<FormState>();
  late TextEditingController passController;
  late TextEditingController emailIDController;

  RxList<DealerModel> dealerList = <DealerModel>[].obs;

  Future getDealerList() async {
    try {
      showloadingIndicators();
      await ApiRepo().getDealerList().then((value) async {
        print(value);
        dealerList.value = (value["data"] as List)
            .map((e) => DealerModel.fromJson(e))
            .toList();

        print("dealerLisats");
        print(dealerList);
      });
    } catch (e) {
      print(e.toString());
    }
    hideLoading();
  }

  RxList<Map<String, dynamic>> menuList = <Map<String, dynamic>>[
    {
      "image": "assets/images/notepad.png",
      "title": "Dealer\n List",
      "page": StationsPage()
    },
    {
      "image": "assets/images/write.png",
      "title": "Service\n Report",
      "page": StationsPage()
    },
    {
      "image": "assets/images/handshake.png",
      "title": "Driver\n Connect",
      "page": const BatteryAndChargerPage()
    },
    {
      "image": "assets/images/note.png",
      "title": "Survey",
      "page": const BatteryAndChargerPage()
    },
    {
      "image": "assets/images/charger.png",
      "title": "Battery &\n Charger",
      "page": const BatteryAndChargerPage()
    },
  ].obs;

  RxList stationsList =
      ["Sanjay", "Santosh", "Sumesh", "Ritika", "Diljeet", "Anushka"].obs;

  RxList<Map<String, dynamic>> batteryAndChargerList = <Map<String, dynamic>>[
    {
      "image": "assets/images/location.png",
      "title": "Track\nBatteries",
      "page": BatteryAndChargerPage()
    },
    {
      "image": "assets/images/qr.png",
      "title": "Generate\n Battery Qr ",
      "page": const BatteryAndChargerPage()
    },
    {
      "image": "assets/images/charger.png",
      "title": "Add\n Charger",
      "page": const BatteryAndChargerPage()
    },
    {
      "image": "assets/images/qr.png",
      "title": "Charger\n Qr",
      "page": const BatteryAndChargerPage()
    }
  ].obs;

  @override
  void onInit() async {
    passController = TextEditingController();
    emailIDController = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    passController.dispose();
    emailIDController.dispose();
    super.dispose();
  }
}
