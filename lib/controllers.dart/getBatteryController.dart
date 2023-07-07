


import 'package:get/get.dart';
import 'package:service/apiService/apiRepo.dart';
import '../localStorage/localStorage.dart';
import '../utils/showLoadingIndicator.dart';


class GetDriverConnectController extends GetxController {  

    LocalStorageController localStorageController =  Get.find();
    RxList getDriverList = [].obs;

    Future getDriverConnect() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["serviceUser_id"] = localStorageController.userToken.value;
    try {
     showloadingIndicators();
      await ApiRepo().driverConnect(data).then((value)  {
                if(value["status"]==1){
                   getDriverList.value = value["data"];
                   print(getDriverList);
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
