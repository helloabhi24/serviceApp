import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/utils/constant.dart';
import 'package:service/view/homePage.dart';
import '../localStorage/localStorage.dart';
import '../utils/customAssetsImage.dart';
import 'loginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
     LocalStorageController localStorageController =  Get.put(LocalStorageController());
    return Obx(()=>
     Scaffold(
        body: Stack(
          children: [
            CustomAssetsImage(
                height: Get.height,
                width: Get.width,
                boxFit: BoxFit.cover,
                imagePath: Constant().splashScreen),
            Center(
              child: AnimatedSplashScreen(
                duration: 2200,
                backgroundColor: Colors.transparent,
                splashIconSize: Get.height * 0.27,
                curve: Curves.easeInCirc,
                splash: CustomAssetsImage(
                    height: Get.height * 0.50,
                    boxFit: BoxFit.cover,
                    imagePath: Constant().logo),
                nextScreen: localStorageController.userToken.value.isEmpty?   SignInPage(): const Homepage() ,
                // token.isNotEmpty ? const MainPage() : const SignInPage(),
                splashTransition: SplashTransition.scaleTransition,
              ),
            ),
          ],
        ),
      ),
    );
  }      

 
}
