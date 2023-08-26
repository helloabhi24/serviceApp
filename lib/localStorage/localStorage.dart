import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageController extends GetxController {
  RxString userToken = "".obs;
  RxString userName = "".obs;
  RxString userEmail = "".obs;
  RxString userImage = "".obs;
  RxString userZone = "".obs;
  RxString userServiceId = "".obs;
  RxString userOnlineStatus = "".obs;
  RxString userPhone = "".obs;
  RxString userSecurityPrice = "".obs;
  RxString userPermanentAddress = "".obs;

  Future setToken(String tokenId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("Token", tokenId);
  }

  getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userToken.value = pref.getString("Token")!;
    return userToken.value;
  }

  Future setUserName(String userName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("username", userName);
  }

  getUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userName.value = pref.getString("username")!;
    return userName.value;
  }

  Future setUserEmail(String emailId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("userEmail", emailId);
  }

  getUserEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userEmail.value = pref.getString("userEmail")!;
    return userEmail.value;
  }

  Future setUserImage(String image) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("userImage", image);
  }

  Future setZone(String zone) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("userZone", zone);
  }

  getUserZone() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userZone.value = pref.getString("userZone")!;
    return userZone.value;
  }

  Future setServiceId(String serviceId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("userServiceId", serviceId);
  }

  getUserServiceId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userServiceId.value = pref.getString("userServiceId")!;
    return userServiceId.value;
  }

  Future setOnlineStatus(String onlineStatus) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("onlineStatus", onlineStatus);
  }

  getOnlineStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userOnlineStatus.value = pref.getString("onlineStatus")!;
    return userOnlineStatus.value;
  }

  Future setPhoneNo(String phoneNum) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("phoneNum", phoneNum);
  }

  getPhoneNum() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userPhone.value = pref.getString("phoneNum")!;
    return userPhone.value;
  }

  Future setSecurityPrice(String securityPrice) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("securityPrice", securityPrice);
  }

  getSecurityPrice() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userSecurityPrice.value = pref.getString("securityPrice")!;
    return userSecurityPrice.value;
  }

  Future setPermanentAdd(String permanentAddress) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("permanentAddress", permanentAddress);
  }

  getPermanentAddress() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userPermanentAddress.value = pref.getString("permanentAddress")!;
    return userPermanentAddress.value;
  }

  getUserImage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userImage.value = pref.getString("userImage")!;
    return userImage.value;
  }

  deleteToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("Token");
    return pref.remove("Token");
  }

  @override
  void onInit() async {
    await getToken();
    await getUserName();
    await getUserEmail();
    await getUserZone();
    await getUserServiceId();
    await getOnlineStatus();
    await getPhoneNum();
    await getSecurityPrice();
    await getPermanentAddress();
    super.onInit();
  }
}
