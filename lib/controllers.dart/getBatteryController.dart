import 'package:get/get.dart';
import 'package:service/apiService/apiRepo.dart';
import '../localStorage/localStorage.dart';
import '../model/driverListModel.dart';
import '../utils/showLoadingIndicator.dart';

class GetDriverConnectController extends GetxController {
  LocalStorageController localStorageController = Get.find();
  // RxList getDriverList = [].obs;
  RxList<DriverListModel> getDriverList = <DriverListModel>[].obs;

  RxString totalCount = "".obs;

  Future getDriverConnect() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["serviceUser_id"] = localStorageController.userToken.value;
    try {
      showloadingIndicators();
      await ApiRepo().driverConnect(data).then((value) {
        if (value["status"] == 1) {
          getDriverList.value = (value["data"] as List)
              .map((e) => DriverListModel.fromJson(e))
              .toList();
          // getDriverList.value = value["data"];
          totalCount.value = value["count"].toString();
          print('This is value of get driver connect');
          print(getDriverList);
          print(totalCount.value);
        }
      });
    } catch (e) {
      print(e.toString());
    }
    hideLoading();
  }

//  @override
//   void onInit() async{
//  await getDriverConnect();
//     super.onInit();
//   }
}
