import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/customAssetsImage.dart';
import 'loginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // String token = "";

  // @override
  // void initState() {
  //   getToken();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomAssetsImage(
              height: Get.height,
              width: Get.width,
              boxFit: BoxFit.cover,
              imagePath: "assets/images/backspl.png"),
          Center(
            child: AnimatedSplashScreen(
              duration: 2200,
              backgroundColor: Colors.transparent,
              splashIconSize: Get.height * 0.27,
              curve: Curves.easeInCirc,
              splash: CustomAssetsImage(
                  height: Get.height * 0.50,
                  boxFit: BoxFit.cover,
                  imagePath: "assets/images/HX.png"),
              nextScreen: const SignInPage(),
              // token.isNotEmpty ? const MainPage() : const SignInPage(),
              splashTransition: SplashTransition.scaleTransition,
            ),
          ),
        ],
      ),
    );
  }

  // getToken() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     token = pref.getString("Token")!;
  //   });
  //   return token;
  // }
}
