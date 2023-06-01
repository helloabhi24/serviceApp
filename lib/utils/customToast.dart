import 'package:fluttertoast/fluttertoast.dart';
import 'package:service/constant/constant.dart';

customeToast(String text) {
  return Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: KColors.persistentBlack,
    textColor: KColors.white,
  );
}
