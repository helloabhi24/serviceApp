import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:service/constant/constant.dart';
import 'package:service/constant/sizeHelper.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/utils/customAssetsImage.dart';
import 'package:service/widgets/homepageWidget.dart';

class Homepage extends GetView<HomepageController> {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: HomePageWidget.customeAppbar(context),
        drawer: const Drawer(),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getHorizontalSize(10), vertical: getVerticalSize(10)),
          child: Column(
            children: [
              const UserDetail(),
              getheight(context, 0.012),
              const UserActivationPage(),
              getheight(context, 0.020),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    child: GridView.builder(
                      addRepaintBoundaries: true,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: Get.height * 0.18,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 8.h,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            await controller.getDealerList();
                            Get.to(controller.menuList[index]["page"]);

                            // index == 0 ? Get.to(const StationsPage()) : null;
                          },
                          child: Container(
                              width: Get.width * 0.30,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                  color: KColors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.menuList[index]["title"]!,
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  width10,
                                  CustomAssetsImage(
                                      imagePath: controller.menuList[index]
                                          ["image"]!,
                                      height: 35.h)
                                ],
                              )),
                        );
                      },
                      itemCount: controller.menuList.length,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
