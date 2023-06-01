import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:service/constant/constant.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/routes.dart/appRoutes.dart';
import '../constant/sizeHelper.dart';
import '../utils/customElevatedButton.dart';
import '../utils/customFormFields.dart';
import '../utils/customText.dart';
import '../utils/validation.dart';

class SignInPage extends GetView<HomepageController> with Validation {
  const SignInPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Stack(children: [
        Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/splashScreen.jpg"),
                  fit: BoxFit.cover)),
          child: null,
        ),
        SizedBox(
          height: Get.height,
          width: Get.width,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: getVerticalSize(100)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                      child: AppText(
                    text: "SwitchX",
                    color: KColors.white,
                    fontSize: 33.sp,
                    fontWeight: FontWeight.w600,
                  )),
                  getheight(context, 0.02),
                  SizedBox(
                    height: Get.height * 0.42,
                    width: Get.width * 0.85,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 15,
                            child: SizedBox(
                              height: Get.height * 0.39,
                              width: Get.width * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 20),
                                child: Form(
                                    key: controller.signinformKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const AppText(
                                          text: "User Id",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        getheight(context, 0.02),
                                        CustomFormField(
                                          icons: Icons.email,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: getHorizontalSize(10),
                                              vertical: getVerticalSize(10)),
                                          validator: emptyValidation,
                                          controller:
                                              controller.emailIDController,
                                          hint: "UserId...",
                                        ),
                                        getheight(context, 0.02),
                                        const AppText(
                                          text: "Password",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        getheight(context, 0.02),
                                        CustomFormField(
                                          icons: Icons.lock,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: getHorizontalSize(10),
                                              vertical: getVerticalSize(10)),
                                          validator: emptyValidation,
                                          controller: controller.passController,
                                          hint: "Password...",
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            child: SizedBox(
                              width: Get.width * 0.8,
                              height: 50,
                              child: Center(
                                child: SizedBox(
                                  width: Get.height * 0.20,
                                  child: CustomElevatedButtons(
                                      isBorder: true,
                                      buttoncolor: KColors.persistentBlack,
                                      height: Get.height * 0.060,
                                      width: Get.width * 0.99,
                                      textcolor: KColors.white,
                                      text: const AppText(
                                        text: "SignIn",
                                      ),
                                      textButton: "SignIn",
                                      ontap: () {
                                        Get.toNamed(Routes.HOME);
                                        // if (controller
                                        //     .signinformKey.currentState!
                                        //     .validate()) {
                                        //   controller
                                        //       .signInUser()
                                        //       .whenComplete(() {
                                        //     if (controller.status.value ==
                                        //         1) {
                                        //       customeToast(
                                        //           controller.message.value);

                                        //       Get.offNamed("/mainpage");
                                        //       Get.delete<
                                        //           SignInPageController>();
                                        //       // Get.to(const MainPage());
                                        //     } else if (controller
                                        //             .status.value ==
                                        //         0) {
                                        //       customeToast(
                                        //           controller.message.value);
                                        //     }
                                        //     {}
                                        //   });
                                        // }
                                      }),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  getheight(context, 0.10)
                ],
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}
