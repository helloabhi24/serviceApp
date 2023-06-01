import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/utils/textExtension.dart';
import '../constant/constant.dart';
import '../constant/sizeHelper.dart';
import '../utils/customAssetsImage.dart';

HomepageController homepageController = Get.find();

class HomePageWidget {
  static customeAppbar(context) {
    return AppBar(
        backgroundColor: KColors.persistentBlack,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAssetsImage(
              imagePath: "assets/images/HX.png",
              height: Get.height * 0.06,
            ),
            getWidth(context, 0.010),
            "SwitchX".f18w7(fontSize: 20.sp)
          ],
        ),
        actions: [
          Row(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async {
                        homepageController.getDealerList();
                      },
                      child: const Icon(Icons.notifications)),
                  const CircleAvatar(radius: 5, backgroundColor: KColors.red)
                ],
              ),
              getWidth(context, 0.030),
              Padding(
                padding: EdgeInsets.only(right: getHorizontalSize(10)),
                child: GestureDetector(
                  onTap: () {},
                  child: const CircleAvatar(
                      radius: 15,
                      backgroundColor: KColors.white,
                      child: CircleAvatar(
                        backgroundColor: KColors.white,
                        radius: 15,
                        child: ClipOval(
                            child: Icon(
                          Icons.person,
                          color: KColors.persistentBlack,
                        )
                            // CachedNetworkImage(
                            //   height: Get.height * 0.20,
                            //   fit: BoxFit.cover,
                            //   imageUrl: "",
                            //   width: Get.width * 0.25,
                            //   // placeholder: (context, url) => const Center(
                            //   //     child: RepaintBoundary(
                            //   //   child: CircularProgressIndicator(
                            //   //     strokeWidth: 2,
                            //   //   ),
                            //   // )),
                            //   errorWidget: (context, url, error) =>
                            //       const Icon(Icons.error),
                            // ),
                            ),
                      )),
                ),
              ),
            ],
          )
        ]);
  }
}

class UserDetail extends GetView<HomepageController> {
  const UserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.11,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: KColors.orange),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(14)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: KColors.white,
                  child: Icon(
                    Icons.person,
                    color: KColors.persistentBlack,
                  ),
                ),
                width13,
                "Sanjay Jha".f18w6(fontSize: 19.sp),
              ],
            ),
            "SE012\nNorth-zone"
                .f16w6(textAlign: TextAlign.center, fontSize: 17.sp)
          ],
        ),
      ),
    );
  }
}

class UserActivationPage extends StatelessWidget {
  const UserActivationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(10)),
      height: Get.height * 0.10,
      width: Get.width,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 5.0,
        ),
      ], borderRadius: BorderRadius.circular(10), color: KColors.white),
      child: Row(
        children: [
          CircleAvatar(
            radius: 6.h,
            backgroundColor: KColors.grey,
          ),
          width13,
          "Offline".f18w6(textColor: KColors.persistentBlack, fontSize: 19),
          Row(
            children: [
              Switch(
                  activeColor: KColors.green,
                  value: true,
                  onChanged: (v) async {
                    // transactionpageController.totalAmount(200);
                    // homepageController.isToggle.value = v;
                    // await homepageController.userStatus();
                    // await homepageController.isOfflineOnlineUser();
                  }),
            ],
          ),
          const Spacer(),
          "Attendance".f18w6(textColor: KColors.persistentBlack),
          width5,
          GestureDetector(
            onTap: () => showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2015, 8),
                lastDate: DateTime(30000)),
            child: const Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
