import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:service/model/userDataModel.dart';
import 'package:service/utils/customToast.dart';
import 'package:service/utils/showDialouge.dart';
import 'package:service/view/driverIdPage.dart';
import 'package:service/view/imagePage.dart';
import 'package:service/view/stationsPage.dart';
import '../apiService/apiRepo.dart';
import '../constant/sizeHelper.dart';
import '../localStorage/localStorage.dart';
import '../model/allDealerModel.dart';
import '../model/dealerModel.dart';
import '../model/driverModel.dart';
import '../model/serviceReportModel.dart';

import '../model/userListModel.dart';
import '../utils/colors.dart';
import '../utils/customText.dart';
import '../utils/showLoadingIndicator.dart';
import '../view/battery&chargerPage.dart';
import '../view/driverOnBoard.dart';
import '../view/serviceReportPage.dart';
import '../view/trackBatteries.dart';

class HomepageController extends GetxController {
  RxList<DealerModel> dealerList = <DealerModel>[].obs;
  RxList<UserListModel> userList = <UserListModel>[].obs;
  RxList uniqueList = [].obs;
  RxList<ServiceReportModel> serviceReportList = <ServiceReportModel>[].obs;
  LocalStorageController localStorageController = Get.find();
  late TextEditingController searchController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController problemNameController;
  late TextEditingController aboutProblemController;
  late TextEditingController chatController;

  late TextEditingController nameConnectionController;
  late TextEditingController phoneConnectionController;
  late TextEditingController aadharConnectionController;
  late TextEditingController securityConnectionController;

  RxString radioButton = "".obs;
  RxString timeSlot = "".obs;
  RxBool isNewDealer = true.obs;

  RxString onBoardingDate = "".obs;

  RxString selectedDate = "".obs;
  RxString selectedDateONBoarding = "".obs;
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

  RxBool servicestatus = false.obs;
  RxBool haspermission = false.obs;
  late LocationPermission permission;
  late Position position;
  RxString long = "".obs, lat = "".obs;
  late StreamSubscription<Position> positionStream;

  RxString currLat = "".obs;
  RxString currLong = "".obs;
  RxString currDay = "".obs;
  RxString serviceUserID = "".obs;

  RxList pendingStatusList = [].obs;
  RxList<Placemark> placemarks = <Placemark>[].obs;
  RxList<UserDataModel> serviceUserData = <UserDataModel>[].obs;
  RxList<DealerListModel> getdealerList = <DealerListModel>[].obs;
  RxList<DriverModel> getDriverDetailList = <DriverModel>[].obs;

  RxString base64stringforBattery = "".obs;
  RxString pathNameforBattery = "".obs;
  var selectedImagePathinBattery = "".obs;

  var selectedImagePathforAadhar = "".obs;
  RxString pathNameforAadhar = "".obs;
  RxString base64stringforAadhar = "".obs;

  var selectedImagePathforRc = "".obs;
  RxString pathNameforRc = "".obs;
  RxString base64stringforRc = "".obs;

  var selectedImagePathforAddtional = "".obs;
  RxString pathNameforAddtional = "".obs;
  RxString base64stringforAddtional = "".obs;

  var selectedImagePathforPhoto = "".obs;
  RxString pathNameforPhoto = "".obs;
  RxString base64stringforPhoto = "".obs;

  late TextEditingController batteryID;
  late TextEditingController addChargerID;
  late TextEditingController chargerID;

  late TextEditingController dealerNameController;
  late TextEditingController driverCountController;
  late TextEditingController batteryCountController;
  late TextEditingController chargerCountController;
  // late TextEditingController wiringMeterController;
  // late TextEditingController fileDataController;
  // RxString userValue = "arun".obs;
  final userValue = Rxn<String>();
  RxString dealerID = "".obs;

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

  Future getDealerList(String search) async {
    try {
      showloadingIndicators();
      await ApiRepo()
          .getDealerList(localStorageController.userToken.value, search)
          .then((value) async {
        dealerList.value = (value["data"] as List)
            .map((e) => DealerModel.fromJson(e))
            .toList();
        print("dealerList");
        print(dealerList);
        // print(
        //     "this is a value of local Storage controller user token value in home page controller");
        // print(localStorageController.userToken.value);
      });
    } catch (e) {
      print(e.toString());
    }
    hideLoading();
  }

  Future getUSersList() async {
    try {
      showloadingIndicators();
      await ApiRepo().getUserList().then((value) async {
        userList.value = (value["data"] as List)
            .map((e) => UserListModel.fromJson(e))
            .toList();
        // uniqueList.value = userList.toSet().toList();

        // userValue.value = userList[0].name + " " + userList[0].dealerId;
        print(userValue);
        print("dealerList");
        print(dealerList);
        print("this is a unique list");
        print(uniqueList.value);
      });
    } catch (e) {
      print(e.toString());
    }
    hideLoading();
  }

  RxList<Map<String, dynamic>> menuList = <Map<String, dynamic>>[
    {
      "image": "assets/images/notepad.png",
      // "title": "Dealer\nList",
      "title": "Dealer List",
      "page": const StationsPage()
    },
    {
      "image": "assets/images/write.png",
      // "title": "Service\nReport",
      "title": "Service Report",
      "page": const ServiceReportPage()
    },
    // {
    //   "image": "assets/images/handshake.png",
    //   // "title": "Driver\nConnect",
    //   "title": "Driver Connect",
    //   // "page": const popup()
    // },
    {
      "image": "assets/images/note.png",
      "title": "Driver OnBoard",
      "page": const DriverOnBoardPage()
    },
    {
      "image": "assets/images/charger.png",
      // "title": "Battery &\nCharger",
      "title": "Battery & Charger",
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
      // "title": "Track\nBatteries",
      "title": "Track Batteries",
      "page": const BatteryAndChargerPage()
    },
    {
      "image": "assets/images/qr.png",
      // "title": "Generate\nBattery Qr ",
      "title": "Generate Battery Qr ",
      "page": const BatteryAndChargerPage()
    },
    {
      "image": "assets/images/charger.png",
      // "title": "Add\nCharger",
      "title": "Add Charger",
      "page": const BatteryAndChargerPage()
    },
    {
      "image": "assets/images/qr.png",
      // "title": "Charger\nQr",
      "title": "Charger Qr",
      "page": const BatteryAndChargerPage()
    }
  ].obs;

  Future serviceReport() async {
    await localStorageController.getToken();
    final Map<String, dynamic> data = <String, dynamic>{};
    data["service_user_id"] = localStorageController.userToken.value;
    print("This is serveice user id");
    print(data["service_user_id"]);
    serviceUserID.value = localStorageController.userToken.value;
    try {
      showloadingIndicators();
      await ApiRepo().serviceReport(data).then((value) async {
        serviceReportList.value = (value["data"] as List)
            .map((e) => ServiceReportModel.fromJson(e))
            .toList();
        print("This is services User states details");
        print(serviceReportList[0].status);
      });

      print("serviceReportlist+++++++++++++++++++++++++++++");
      print(serviceReportList);
    } catch (e) {
      print(e.toString());
    }

    hideLoading();
  }

  Future serviceUpdate(String id, String status) async {
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
      await ApiRepo().referDriver(data).then((value) {});
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
      await ApiRepo().status(data).then((value) {
        isUpdated.value = value["is_online"];
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
    await determinePosition();
    final Map<String, dynamic> data = <String, dynamic>{};
    data["serviceUser_id"] = localStorageController.userToken.value;
    data["date"] = selectedDate.value;
    data["location"] = address.value + pinCode.value + country.value;
    try {
      showloadingIndicators();
      await ApiRepo().attendenceMark(data).then((value) {
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
    ProblemType == "BatteryQR"
        ? data["device_id"] = homepageController.batteryID.text
        : ProblemType == "ChargerQR"
            ? data["device_id"] = homepageController.addChargerID.text
            : data["device_id"] = homepageController.chargerID.text;
    print(data["serviceUser_id"]);
    print(data["message"]);
    print(data["user_id"]);
    print(data["problem_type"]);
    print("this is data");
    print(data);

    try {
      showloadingIndicators();
      await ApiRepo().batteryChargerProblem(data).then((value) {
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
      await ApiRepo().dealerList(data).then((value) {
        if (value["status"] == 1) {
          getdealerList.value = (value["data"] as List)
              .map((e) => DealerListModel.fromJson(e))
              .toList();
          print("getdealerlist");
          print(getdealerList);
          print(
              "this is a value of local Storage controller user token value in home page controller");
          print(localStorageController.userToken.value);
        } else {
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
      await ApiRepo().getDriverdetail(data).then((value) {
        if (value["status"] == 1) {
          getDriverDetailList.value = (value["data"] as List)
              .map((e) => DriverModel.fromJson(e))
              .toList();
          print("getdriverList");
          print(getDriverDetailList);
        } else {
          customeToast(value['message']);
        }
      });
    } catch (e) {
      print(e.toString());
    }

    hideLoading();
  }

  Future getDealerSurveys() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = dealerNameController.text;
    data["driver_count"] = driverCountController.text;
    data["battery_count"] = batteryCountController.text;
    data["charger_count"] = chargerCountController.text;
    data["wiring_meter"] = radioButton.value;
    data["filedata"] = base64stringforBattery.value;
    //  print(data["serviceUser_id"]);
    try {
      showloadingIndicators();
      await ApiRepo().getDealerSurvey(data).then((value) {
        if (value["status"] == 1) {
          customeToast(value['message']);
          Get.back();
          // getDriverDetailList.value = (value["data"] as List)
          //     .map((e) => DriverModel.fromJson(e))
          //     .toList();
          // print("getdriverList");
          // print(getDriverDetailList);
        } else {
          customeToast(value['message']);
        }
      });
    } catch (e) {
      print(e.toString());
    }

    hideLoading();
  }

  Future addDrivers() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = nameConnectionController.text;
    data["image"] = base64stringforPhoto.value;
    data["aadhar_number"] = aadharConnectionController.text;
    data["security"] = securityConnectionController.text;
    data["phone"] = phoneConnectionController.text;
    data["date"] = onBoardingDate.value;
    data["status"] = "1";
    data["user"] = dealerID.value;
    data["adhar_image"] = base64stringforAadhar.value;
    data["rc_image"] = base64stringforRc.value;
    //  print(data["serviceUser_id"]);
    try {
      showloadingIndicators();
      await ApiRepo().addDriver(data).then((value) {
        if (value["status"] == 1) {
          customeToast(value['message']);
          Get.back();
          // getDriverDetailList.value = (value["data"] as List)
          //     .map((e) => DriverModel.fromJson(e))
          //     .toList();
          // print("getdriverList");
          // print(getDriverDetailList);
        } else {
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
    // showloadingIndicators();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission asked = await Geolocator.requestPermission();
      return Get.snackbar("Permission not given ", "");
    } else {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("this is value of current lat long ");
      print(currentPosition.latitude);
      print(currentPosition.longitude);
      currLat.value = currentPosition.latitude.toString();
      currLong.value = currentPosition.longitude.toString();
      await getAddress(currentPosition.latitude, currentPosition.longitude)
          .then((value) {});
    }
    // hideLoading();
  }

  getDay() {
    var date = DateTime.now();
    print("This is the value of day in 4 character");
    print(DateFormat('EEEE').format(date).substring(0, 3).toLowerCase());
    currDay.value =
        DateFormat('EEEE').format(date).substring(0, 3).toLowerCase();
  }

  Future getLocationFrequently() async {
    print("this is the value of serviceUser ID");
    print(serviceUserID.value);
    if (serviceUserID.value.isNotEmpty) {
      final Map<String, dynamic> data = <String, dynamic>{};
      Map<String, dynamic> locationdata = <String, dynamic>{};
      print("This is postion function call");
      await determinePosition();
      print("this is the value of lat long in under the function");
      print(currLat.value);
      print(currLong.value);
      print("This is day function call");
      await getDay();
      locationdata = {"lat": currLat.value, "lng": currLong.value};
      // locationdata["lng"] = currLong.value;
      data["service_user_id"] = serviceUserID.value;
      data["day"] = currDay.value;
      data["location"] = locationdata;
      print(data);
      try {
        // showloadingIndicators();
        await ApiRepo().addLocation(data).then((value) async {
          if (value["status"] == 1) {
            print(value["message"]);
          }
        });
      } catch (e) {
        print(e.toString());
      }

      // hideLoading();
    }
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
      await ApiRepo()
          .getServiceUserList(localStorageController.userToken.value)
          .then((value) {
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

  navigatetoPage(int index) {
    switch (index) {
      case 0:
        {
          Get.to(const TrackBatteries());
        }
        break;

      case 1:
        {
          //  Get.to(const StationsPage());
          batteryChargerProblems(Get.context);
        }
        break;

      case 2:
        {
          batteryQrProblems(Get.context);
        }
        break;

      case 3:
        {
          chargerQrProblems(Get.context);
        }
        break;
    }
  }

  sendImage(
    String chatroomId,
  ) {
    if (selectedImagePath.value.isNotEmpty) {
      FirebaseFirestore.instance.collection("ChatRoom").doc().set({
        "sender": localStorageController.userName.value,
        "image": base64string,
        "createdOn": DateTime.now(),
      });
    }
  }

  fileSelectedWidgetForAadhar(context) {
    return Obx(
      () => Padding(
          padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getheight(context, 0.010),
              getheight(context, 0.010),
              GestureDetector(
                onTap: () {
                  getImageforAadhar(ImageSource.gallery);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: Get.height * 0.20,
                  width: Get.width * 0.93,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.greyColor),
                    borderRadius: BorderRadius.circular(10),
                    // color: AppColor.redColor,
                  ),
                  child: homepageController
                          .selectedImagePathforAadhar.value.isEmpty
                      ? AppText(
                          text: "Please Upload an Image of AADAHR",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        )
                      : Image.file(
                          File(homepageController
                              .selectedImagePathforAadhar.value),
                          fit: BoxFit.cover,
                          width: Get.width,
                        ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.60,
                child: AppText(
                  textOverflow: TextOverflow.ellipsis,
                  text: pathNameforAadhar.value.isEmpty
                      ? ""
                      : pathNameforAadhar.value,
                ),
              ),
            ],
          )),
    );
  }

  Future getImageforBattery(ImageSource imageSource) async {
    var pickeImage = await ImagePicker().pickImage(source: imageSource);
    if (pickeImage != null) {
      File? img = await getCroppedImage(pickeImage);
      pathNameforBattery.value = pickeImage.name;
      selectedImagePathinBattery.value = await img!.path;

      File imagefile =
          File(selectedImagePathinBattery.value); //convert Path to File
      Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
      base64stringforBattery.value =
          "data:image/jpeg;base64," + base64.encode(imagebytes);
      print("byteImage");
      // print(base64string.value); //convert bytes to base64 string
      // await editPageController.getUpdateProfile(base64string.value);
      // await convertImageIntoByte();

      // print(selectedImagePath.value);
    } else {
      customeToast("No Image Selected");
    }
  }

  Future getImageforAdditional(ImageSource imageSource) async {
    var pickeImage = await ImagePicker().pickImage(source: imageSource);
    if (pickeImage != null) {
      File? img = await getCroppedImage(pickeImage);
      pathNameforAddtional.value = pickeImage.name;
      selectedImagePathforAddtional.value = await img!.path;

      File imagefile =
          File(selectedImagePathforAddtional.value); //convert Path to File
      Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
      base64stringforAddtional.value =
          "data:image/jpeg;base64," + base64.encode(imagebytes);
      print("byteImage");
      // print(base64string.value); //convert bytes to base64 string
      // await editPageController.getUpdateProfile(base64string.value);
      // await convertImageIntoByte();

      // print(selectedImagePath.value);
    } else {
      customeToast("No Image Selected");
    }
  }

  Future getImageforRc(ImageSource imageSource) async {
    var pickeImage = await ImagePicker().pickImage(source: imageSource);
    if (pickeImage != null) {
      File? img = await getCroppedImage(pickeImage);
      pathNameforRc.value = pickeImage.name;
      selectedImagePathforRc.value = await img!.path;

      File imagefile =
          File(selectedImagePathforRc.value); //convert Path to File
      Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
      base64stringforRc.value =
          "data:image/jpeg;base64," + base64.encode(imagebytes);
      print("byteImage");
      // print(base64string.value); //convert bytes to base64 string
      // await editPageController.getUpdateProfile(base64string.value);
      // await convertImageIntoByte();

      // print(selectedImagePath.value);
    } else {
      customeToast("No Image Selected");
    }
  }

  Future getImageforAadhar(ImageSource imageSource) async {
    var pickeImage = await ImagePicker().pickImage(source: imageSource);
    if (pickeImage != null) {
      File? img = await getCroppedImage(pickeImage);
      pathNameforAadhar.value = pickeImage.name;
      selectedImagePathforAadhar.value = await img!.path;

      File imagefile =
          File(selectedImagePathforAadhar.value); //convert Path to File
      Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
      base64stringforAadhar.value =
          "data:image/jpeg;base64," + base64.encode(imagebytes);
      print("byteImage");
      // print(base64string.value); //convert bytes to base64 string
      // await editPageController.getUpdateProfile(base64string.value);
      // await convertImageIntoByte();

      // print(selectedImagePath.value);
    } else {
      customeToast("No Image Selected");
    }
  }

  Future getImageforPhoto(ImageSource imageSource) async {
    var pickeImage = await ImagePicker().pickImage(source: imageSource);
    if (pickeImage != null) {
      File? img = await getCroppedImage(pickeImage);
      pathNameforPhoto.value = pickeImage.name;
      selectedImagePathforPhoto.value = await img!.path;

      File imagefile =
          File(selectedImagePathforPhoto.value); //convert Path to File
      Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
      base64stringforPhoto.value =
          "data:image/jpeg;base64," + base64.encode(imagebytes);
      print("byteImage");
      // print(base64string.value); //convert bytes to base64 string
      // await editPageController.getUpdateProfile(base64string.value);
      // await convertImageIntoByte();

      // print(selectedImagePath.value);
    } else {
      customeToast("No Image Selected");
    }
  }

  fileSelectedWidgetForBattery(context) {
    return Obx(
      () => Padding(
          padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getheight(context, 0.010),
              getheight(context, 0.010),
              GestureDetector(
                onTap: () {
                  getImageforBattery(ImageSource.gallery);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: Get.height * 0.20,
                  width: Get.width * 0.93,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.greyColor),
                    borderRadius: BorderRadius.circular(10),
                    // color: AppColor.redColor,
                  ),
                  child: homepageController
                          .selectedImagePathinBattery.value.isEmpty
                      ? AppText(
                          text: "Please Upload an Image of Battery",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        )
                      : Image.file(
                          File(homepageController
                              .selectedImagePathinBattery.value),
                          fit: BoxFit.cover,
                          width: Get.width,
                        ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.60,
                child: AppText(
                  textOverflow: TextOverflow.ellipsis,
                  text: pathNameforBattery.value.isEmpty
                      ? ""
                      : pathNameforBattery.value,
                ),
              ),
            ],
          )),
    );
  }

  fileSelectedWidgetForRc(context) {
    return Obx(
      () => Padding(
          padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getheight(context, 0.010),
              getheight(context, 0.010),
              GestureDetector(
                onTap: () {
                  getImageforRc(ImageSource.gallery);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: Get.height * 0.20,
                  width: Get.width * 0.93,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.greyColor),
                    borderRadius: BorderRadius.circular(10),
                    // color: AppColor.redColor,
                  ),
                  child: homepageController.selectedImagePathforRc.value.isEmpty
                      ? AppText(
                          text: "Please Upload an Image of R/C",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        )
                      : Image.file(
                          File(homepageController.selectedImagePathforRc.value),
                          fit: BoxFit.cover,
                          width: Get.width,
                        ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.60,
                child: AppText(
                  textOverflow: TextOverflow.ellipsis,
                  text: pathNameforRc.value.isEmpty ? "" : pathNameforRc.value,
                ),
              ),
            ],
          )),
    );
  }

  fileSelectedWidgetForAdditional(context) {
    return Obx(
      () => Padding(
          padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getheight(context, 0.010),
              getheight(context, 0.010),
              GestureDetector(
                onTap: () {
                  getImageforAdditional(ImageSource.gallery);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: Get.height * 0.20,
                  width: Get.width * 0.93,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.greyColor),
                    borderRadius: BorderRadius.circular(10),
                    // color: AppColor.redColor,
                  ),
                  child: homepageController
                          .selectedImagePathforAddtional.value.isEmpty
                      ? AppText(
                          text: "Please Upload an Image of Additonal",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        )
                      : Image.file(
                          File(homepageController
                              .selectedImagePathforAddtional.value),
                          fit: BoxFit.cover,
                          width: Get.width,
                        ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.60,
                child: AppText(
                  textOverflow: TextOverflow.ellipsis,
                  text: pathNameforAddtional.value.isEmpty
                      ? ""
                      : pathNameforAddtional.value,
                ),
              ),
            ],
          )),
    );
  }

  fileSelectedWidgetForPhoto(context) {
    return Obx(
      () => Padding(
          padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getheight(context, 0.010),
              getheight(context, 0.010),
              GestureDetector(
                onTap: () {
                  getImageforPhoto(ImageSource.gallery);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: Get.height * 0.20,
                  width: Get.width * 0.50,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.greyColor),
                    borderRadius: BorderRadius.circular(10),
                    // color: AppColor.redColor,
                  ),
                  child:
                      homepageController.selectedImagePathforPhoto.value.isEmpty
                          ? AppText(
                              text: "Please Upload Photo",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            )
                          : Image.file(
                              File(homepageController
                                  .selectedImagePathforPhoto.value),
                              fit: BoxFit.cover,
                              width: Get.width,
                            ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.60,
                child: AppText(
                  textOverflow: TextOverflow.ellipsis,
                  text: pathNameforPhoto.value.isEmpty
                      ? ""
                      : pathNameforPhoto.value,
                ),
              ),
            ],
          )),
    );
  }

  sendMessage(
    String chatroomId,
  ) {
    String msg = chatController.text.trim();
    chatController.clear();
    if (msg != "") {
      FirebaseFirestore.instance.collection("ChatRoom").doc().set({
        "sender": localStorageController.userName.value,
        "msg": sliderList.isEmpty ? msg : "",
        "createdOn": DateTime.now(),
        "image": sliderList.isEmpty ? "" : sliderList[0],
      });
    } else {
      FirebaseFirestore.instance.collection("ChatRoom").doc().set({
        "sender": localStorageController.userName.value,
        "msg": sliderList.isEmpty ? "" : msg,
        "createdOn": DateTime.now(),
        "image": sliderList.isEmpty ? "" : sliderList[0],
      });
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
      selectedImagePath.value = img!.path;
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
    Uint8List imageByte = File(selectedImagePath.value).readAsBytesSync();
    base64string = base64.encode(imageByte);
    print("base64image");
    print(base64string);

    return base64string;
  }

  checkGps() async {
    servicestatus.value = await Geolocator.isLocationServiceEnabled();
    if (servicestatus.value) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission.value = true;
        }
      } else {
        haspermission.value = true;
      }

      if (haspermission.value) {
        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long.value = position.longitude.toString();
    lat.value = position.latitude.toString();

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long.value = position.longitude.toString();
      lat.value = position.latitude.toString();
    });
  }

  @override
  void onInit() async {
    searchController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    problemNameController = TextEditingController();
    aboutProblemController = TextEditingController();
    chatController = TextEditingController();
    batteryID = TextEditingController();
    addChargerID = TextEditingController();
    chargerID = TextEditingController();
    dealerNameController = TextEditingController();
    driverCountController = TextEditingController();
    batteryCountController = TextEditingController();
    chargerCountController = TextEditingController();
    nameConnectionController = TextEditingController();
    phoneConnectionController = TextEditingController();
    aadharConnectionController = TextEditingController();
    securityConnectionController = TextEditingController();

    await localStorageController.getToken();
    await localStorageController.getUserEmail();
    await localStorageController.getUserName();
    await localStorageController.getUserImage();
    // getLocation();
    // await determinePosition();
    // getDay();
    // checkGps();
    getAllDealerList();
    statusOnline("1");
    await serviceReport();
    getUserList();
    await getAllDealerList();
    getDriverdetail();
    // getLocation();
    // await getLocationFrequently();
    Timer.periodic(
        Duration(minutes: 1), (Timer t) async => await getLocationFrequently());

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
    nameConnectionController.dispose();
    phoneConnectionController.dispose();
    aadharConnectionController.dispose();
    securityConnectionController.dispose();
    super.dispose();
  }
}
