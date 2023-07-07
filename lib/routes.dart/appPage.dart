import 'package:get/get.dart';
import 'package:service/view/batteryDetailPage.dart';
import '../Bindings/controllersBindings.dart';
import '../view/homePage.dart';
import '../view/loginPage.dart';
import 'appRoutes.dart';

class AppPage {
  AppPage._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
        name: "/home", page: (() => const Homepage()), binding: GetXbindings()),
    GetPage(
        name: "/batterydetailpage",
        page: (() => const BatteryDetailPage()),
        binding: GetXbindings()),

        GetPage(
        name: "/singinpage",
        page: (() => const SignInPage()),
        binding: GetXbindings()),
  ];
}
