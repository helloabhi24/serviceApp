import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationAccessController extends GetxController {
  RxDouble userLat = 0.0.obs;
  RxDouble userLong = 0.0.obs;

  Future<Position> getCurrentPositions() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error("Location Services are disabled. ");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Services are disabled. ");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permission are permanenty denied, we cannot request permission.");
    }
    return await Geolocator.getCurrentPosition();
  }

  fetchLocation() {
    getCurrentPositions().then((value) {
      userLat.value = value.latitude;
      userLong.value = value.longitude;
      print(userLat.value);
      print(userLong.value);
    });
  }

  @override
  void onInit() async {
    await getCurrentPositions();
    fetchLocation();
    super.onInit();
  }
}
