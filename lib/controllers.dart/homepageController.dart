
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service/model/userDataModel.dart';
import 'package:service/utils/customToast.dart';
import 'package:service/utils/showDialouge.dart';
import 'package:service/view/driverIdPage.dart';
import 'package:service/view/imagePage.dart';
import 'package:service/view/stationsPage.dart';
import '../apiService/apiRepo.dart';
import '../localStorage/localStorage.dart';
import '../model/allDealerModel.dart';
import '../model/dealerModel.dart';
import '../model/driverModel.dart';
import '../model/serviceReportModel.dart';
import '../utils/showLoadingIndicator.dart';
import '../view/battery&chargerPage.dart';
import '../view/serviceReportPage.dart';

class HomepageController extends GetxController {

  RxList<DealerModel> dealerList = <DealerModel>[].obs;
  RxList<ServiceReportModel> serviceReportList = <ServiceReportModel>[].obs;
  LocalStorageController localStorageController =  Get.find();
  late TextEditingController searchController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController problemNameController;
  late TextEditingController aboutProblemController;
  late TextEditingController chatController;
  RxString selectedDate = "".obs;
  RxString address = "".obs;
  RxBool isStatus = false.obs;
  RxString pinCode = "".obs;
  RxBool isswitch = false.obs;
  RxBool isUpdated = false.obs;
  RxBool updateStatusValue = false.obs;
  RxString country = "".obs;
  RxString userName = "".obs;
  RxString userId = "".obs;
  RxString problemType = "".obs;
  RxString problemType2 = "".obs;
  RxString problemType3 = "".obs;
  RxString userIdvalue = "".obs;
  RxString userIdvalue2 = "".obs;
  RxString userIdvalue3 = "".obs;
  RxBool isshow = false.obs;
  RxBool isshow2 = false.obs;
  RxBool isshow3 = false.obs;
  RxBool isshowDriverId = false.obs;
  RxBool isshowDriverId2 = false.obs;
  RxBool isshowDriverId3 = false.obs;
  RxBool isshowDropDown = false.obs;
  RxBool showValue = false.obs;
  
  RxList pendingStatusList = [].obs;
  RxList<Placemark> placemarks = <Placemark>[].obs;
  RxList<UserDataModel> serviceUserData = <UserDataModel>[].obs;
  RxList<DealerListModel> getdealerList = <DealerListModel>[].obs;
  RxList<DriverModel> getDriverDetailList = <DriverModel>[].obs;
  

  RxList problemTypeList = [
    "New Battery add",
    "Battery Fault",
    "Battery damage",
    "BatteryQR",
  ].obs;

   RxList userIdList = [
    "23"
    "44",
    "65",   
  ].obs;

    RxList addProblemTypeList = [
     "Qr not genrate",
    "Qr not work",
    "Qr done",
    
  ].obs;

    RxList generateBatteryproblemTypeList = [
    "New Battery add",
    "Battery Fault",
    "Battery damage",
    "BatteryQR",
  ].obs;


  Future getDealerList() async {
    try {
      showloadingIndicators();
      await ApiRepo().getDealerList(localStorageController.userToken.value).then((value) async {
        dealerList.value = (value["data"] as List)
            .map((e) => DealerModel.fromJson(e))
            .toList();
           print("dealerList");
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
      "title": "Dealer\nList",
      "page": const StationsPage()
    },
    {
      "image": "assets/images/write.png",
      "title": "Service\nReport",
      "page": const  ServiceReportPage()
    },
    {
      "image": "assets/images/handshake.png",
      "title": "Driver\nConnect",
      // "page": const popup()
    },
    {
      "image": "assets/images/note.png",
      "title": "Survey",
      "page": const BatteryAndChargerPage()
    },
    {
      "image": "assets/images/charger.png",
      "title": "Battery &\nCharger",
      "page": const BatteryAndChargerPage()
    },
    {
      "image": "assets/images/id.png",
      "title": "Driver List",
      "page": const DriverIdPage()
    },

  ].obs;


  RxList stationsList =
      ["Sanjay", "Santosh", "Sumesh", "Ritika", "Diljeet", "Anushka"].obs;

  RxList<Map<String, dynamic>> batteryAndChargerList = <Map<String, dynamic>>[
    {
      "image": "assets/images/location.png",
      "title": "Track\nBatteries",
      "page": const BatteryAndChargerPage()
    },
    {
      "image": "assets/images/qr.png",
      "title": "Generate\nBattery Qr ",
      "page": const BatteryAndChargerPage()
    },
    {
      "image": "assets/images/charger.png",
      "title": "Add\nCharger",
      "page": const BatteryAndChargerPage()
    },
    {
      "image": "assets/images/qr.png",
      "title": "Charger\nQr",
      "page": const BatteryAndChargerPage()
    }
  ].obs;

  Future serviceReport() async {
  await localStorageController.getToken();
  final Map<String, dynamic> data = <String, dynamic>{};
    data["service_user_id"] = localStorageController.userToken.value;
    try {
     showloadingIndicators();
      await ApiRepo().serviceReport(data).then((value) async {
                serviceReportList.value = (value["data"] as List)
            .map((e) => ServiceReportModel.fromJson(e))
            .toList();
            
              });
              
              print("serviceReportlist+++++++++++++++++++++++++++++");
              print(serviceReportList);
    } catch (e) {
      print(e.toString());
    }
  
    hideLoading();
  }


   Future serviceUpdate(String id , String status) async {
    final Map<String, dynamic> data = <String, dynamic>{};
   
    data["id"] = id;
    data["status"] = status;
    print("id");
    print(data["id"]);
    try {
     showloadingIndicators();
      await ApiRepo().serviceUpdate(data).then((value) async {
                // updateStatusValue.value = value["data"];
              });
            
    } catch (e) {
      print(e.toString());
    }
  
    hideLoading();
  }



    Future refer() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["serviceuser_id"] = localStorageController.userToken.value;
    data["name"] = nameController.text;
    data["phone"] = phoneController.text;
    data["status"] = "1";
    try {
     showloadingIndicators();
      await ApiRepo().referDriver(data).then((value)  {
              
      });
            
    } catch (e) {
      print(e.toString());
    }
     nameController.clear();
     phoneController.clear();
    hideLoading();
  }

  
    Future statusOnline(String status) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["serviceUser_id"] = localStorageController.userToken.value;
    data["status"] = status;
    try {
     showloadingIndicators();
      await ApiRepo().status(data).then((value)  {
                isUpdated.value =  value["is_online"];
                customeToast("updated successfully");
                print(isUpdated.value);
              });
            
    } catch (e) {
      print(e.toString());
    }
     nameController.clear();
     phoneController.clear();
    hideLoading();
  }



    Future attendence() async {
    await  determinePosition();
    final Map<String, dynamic> data = <String, dynamic>{};
    data["serviceUser_id"] = localStorageController.userToken.value;
    data["date"] = selectedDate.value;
    data["location"] = address.value+pinCode.value+country.value;
    try {
     showloadingIndicators();
      await ApiRepo().attendenceMark(data).then((value)  {
                customeToast(value['message']);
    });
            
    } catch (e) {
      print(e.toString());
    }
     nameController.clear();
     phoneController.clear();
    hideLoading();
  }


     Future batteryChargerProblem(String ProblemType) async {
     HomepageController homepageController = Get.find();
    final Map<String, dynamic> data = <String, dynamic>{};
    data["serviceUser_id"] = localStorageController.userToken.value;
    data["message"] = homepageController.aboutProblemController.text;
    data["user_id"] = homepageController.userId.value;
    data["problem_type"] = ProblemType;

    print(data["serviceUser_id"]);
    print(data["message"]);
    print(data["user_id"]);
    print(data["problem_type"]);

    try {
     showloadingIndicators();
      await ApiRepo().batteryChargerProblem(data).then((value)  {
                customeToast(value['message']);
              });
            
    } catch (e) {
      print(e.toString());
    }
     problemNameController.clear();
     aboutProblemController.clear();
    hideLoading();
  }



  
    Future getAllDealerList() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["serviceUser_id"] = localStorageController.userToken.value;
    print(data["serviceUser_id"]);   
    try {
     showloadingIndicators();
      await ApiRepo().dealerList(data).then((value)  {
        if(value["status"]==1){
         getdealerList.value = (value["data"] as List)
            .map((e) => DealerListModel.fromJson(e))
            .toList();
            print("getdealerlist");
             print(getdealerList);
        }else{
          customeToast(value['message']);
        }
        });

    } catch (e) {
      print(e.toString());
    }
 
    hideLoading();
  }


    Future getDriverdetail() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["serviceUser_id"] = localStorageController.userToken.value;
    print(data["serviceUser_id"]);   
    try {
     showloadingIndicators();
      await ApiRepo().getDriverdetail(data).then((value)  {
        if(value["status"]==1){
          getDriverDetailList.value = (value["data"] as List)
            .map((e) => DriverModel.fromJson(e))
            .toList();
            print("getdriverList");
            print(getDriverDetailList);
        }else{
          customeToast(value['message']);
        }
        });

    } catch (e) {
      print(e.toString());
    }
 
    hideLoading();
  }


     Future determinePosition() async {
    LocationPermission permission;
    Position currentPosition;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    showloadingIndicators();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission asked = await Geolocator.requestPermission();
      return Get.snackbar("Permission not given ", "");
    } else {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      await getAddress(currentPosition.latitude, currentPosition.longitude)
          .then((value) {
      });

    }
     hideLoading();
  }

  //For convert lat long to address
  Future getAddress(double lat, double long) async {
    print("done all things");
     placemarks.value = await placemarkFromCoordinates(lat, long);

    address.value =
        " ${placemarks[0].name!} ${placemarks[0].subLocality!} ${placemarks[0].locality} ${placemarks[0].administrativeArea!} ";

    pinCode.value = placemarks[0].postalCode!;

    country.value = placemarks[0].country!;

  }

    Future getUserList() async {
    try {
     showloadingIndicators();
      await ApiRepo().getServiceUserList(localStorageController.userToken.value).then((value)  {
        serviceUserData.value = (value["data"] as List)
            .map((e) => UserDataModel.fromJson(e))
            .toList();
        print("alluserDeatails");
        print(value);
        print(serviceUserData);
      });
            
    } catch (e) {
      print(e.toString());
    }

    hideLoading();
  }


  navigatetoPage(int index ){
  switch(index){
   case 0 :{
   Get.to(const StationsPage());
   }
   break;

   case 1 :{
      //  Get.to(const StationsPage());
       batteryChargerProblems(Get.context);
       }
       break;
   
   case 2 :{
         batteryQrProblems(Get.context);
         }
       break;
  
   case 3 :{
        chargerQrProblems(Get.context);
        }
        break;
  }
   }


    sendImage(String chatroomId,) {
    if (selectedImagePath.value.isNotEmpty) {
      FirebaseFirestore.instance
          .collection("ChatRoom").doc().set({
            "sender": localStorageController.userName.value,
            "image":base64string,"createdOn":DateTime.now(), });
    
    }
  }

    sendMessage(
    String chatroomId,
  ) {
    String msg = chatController.text.trim();
    chatController.clear();
    if (msg != "") {
      FirebaseFirestore.instance
          .collection("ChatRoom").doc().set({
            "sender":  localStorageController.userName.value,
          "msg":sliderList.isEmpty?msg:"","createdOn":DateTime.now(), "image":sliderList.isEmpty?"":sliderList[0],}); 
    }else{
        FirebaseFirestore.instance
          .collection("ChatRoom").doc().set({
            "sender":  localStorageController.userName.value,
          "msg":sliderList.isEmpty?"":msg,"createdOn":DateTime.now(), "image":sliderList.isEmpty?"":sliderList[0],}); 
    }
  }


  var selectedImagePath = "".obs;
  String base64string = "";
  RxList<String> sliderList = <String>[].obs;

 getImage(ImageSource imageSource) async {
    sliderList.clear();
    XFile? pickeImage = await ImagePicker().pickImage(source: imageSource);
    if (pickeImage != null) {
      print("arun");
      File? img = await getCroppedImage(pickeImage);
      print(pickeImage);
      selectedImagePath.value =  img!.path;
      print("selcested image path");
      print(selectedImagePath.value);

      convertImageIntoByte().then((value) => sliderList.add(value));
      Get.to(const ImagePage());
    } else {
      Get.snackbar("No Image Selected", "",
          snackPosition: SnackPosition.BOTTOM);
    }
  }


  getCroppedImage(XFile image) async {
    CroppedFile? croppedFile =
        await ImageCropper().cropImage(sourcePath: image.path);
    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }





  Future convertImageIntoByte() async {
    Uint8List imageByte =  File(selectedImagePath.value).readAsBytesSync();
    base64string = base64.encode(imageByte);
    print("base64image");
    print(base64string);
    
    return base64string;
  }

  @override
  void onInit() async{
    await localStorageController.getToken();
  await localStorageController.getUserEmail();
  await localStorageController.getUserName();
  await localStorageController.getUserImage();
   searchController = TextEditingController();
   nameController = TextEditingController();
   phoneController = TextEditingController();
   problemNameController = TextEditingController();
   aboutProblemController = TextEditingController();
   chatController = TextEditingController();
    getAllDealerList();
   statusOnline("1");
    serviceReport();
    getUserList();
   await getAllDealerList();
    getDriverdetail();
    super.onInit();
  }

 
  @override
  void dispose() {
    searchController.dispose();
    nameController.dispose();
    phoneController.dispose();
    problemNameController.dispose();
    aboutProblemController.dispose();
    chatController.dispose();
    super.dispose();
  }
 
}
