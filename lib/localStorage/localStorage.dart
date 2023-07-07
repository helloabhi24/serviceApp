
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageController extends GetxController {
  RxString userToken = "".obs;
  RxString userName = "".obs;
  RxString userEmail = "".obs;
  RxString userImage = "".obs;


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
  void onInit() async{
   await getToken();
   await getUserName();
   await getUserEmail();
    super.onInit();
  }

}
