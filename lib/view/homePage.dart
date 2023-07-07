import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:service/constant/constant.dart';
import 'package:service/constant/sizeHelper.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/localStorage/localStorage.dart';
import 'package:service/utils/customAssetsImage.dart';
import 'package:service/utils/customText.dart';
import 'package:service/widgets/homepageWidget.dart';
import '../utils/showDialouge.dart';

class Homepage extends GetView<HomepageController> {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    LocalStorageController localStorageController = Get.find();
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
          appBar: HomePageWidget.customeAppbar(context),
          drawer:  Drawer(
            child: Column(
              children: [
                DrawerHeader(decoration:const  BoxDecoration(color: KColors.orange),
                  child: ListView(
                  children: [
                    localStorageController.userImage.value.isEmpty? CircleAvatar(child: Icon(Icons.person),):
                    Container(decoration: BoxDecoration(shape: BoxShape.circle , image: DecorationImage(fit: BoxFit.cover,
                      image: NetworkImage("https://admin.switchxenergy.com/uploads/user_service/${localStorageController.userImage.value}"))),
                      height: 60,width: 60,) ,  
                   height10,
                   Align(alignment: Alignment.center,
                    child: AppText(text: localStorageController.userName.value, color: KColors.white,)),
                   height10,
                   Align(alignment: Alignment.center,
                    child: AppText(text: localStorageController.userEmail.value,color: KColors.white,))
                  ],
                )),
                ListTile(
                    onTap: () {
                      showMyDialog(context);
                    },
                    title: const AppText(
                      text: "Logout",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: KColors.persistentBlack
                    ),
                    trailing: const Icon(
                      Icons.logout,
                      color: KColors.persistentBlack
                    ),
                  ),

                   Obx(
                  () => SizedBox(
                    height: Get.height * 0.64,
                    child: 
                          ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Card(elevation: 0.4,
                                    child: ListTile(tileColor: KColors.red.withOpacity(0.1),
                                      onTap: (){
                                    
                                   viewDealerDetails(context , index);
                                    },
                                      leading:const Icon(Icons.person , color: KColors.persistentBlack,),
                                      trailing:const Icon(Icons.arrow_forward_ios , size: 13,),
                                      title: AppText(text: controller.getdealerList[index].name!,fontSize: 17.sp,fontWeight: FontWeight.w600,),),
                                  );
                                },
                                itemCount: controller.getdealerList.length,
                              ),
                  ),
                ),
              ],
            ),
          ),
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
                      child: AnimationLimiter(
                        child: GridView.builder(
                          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          addRepaintBoundaries: true,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: Get.height * 0.18,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 8.h,
                          ),
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredGrid(columnCount: 2,duration: Duration(milliseconds: 3000),
                              position: index, child: SlideAnimation(child: FadeInAnimation(child: GestureDetector(
                              onTap: () async {
                                await controller.getDealerList();
                                index==2? popup(context):
                                Get.to(controller.menuList[index]["page"]);
                                // index == 0 ? Get.to(const StationsPage()) : null;
                              },
                              child: Container(alignment: Alignment.center,
                                  width: Get.width * 0.30,
                                  decoration: BoxDecoration(
                                      boxShadow:  [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
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
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      getWidth(context, 0.020),
                                      CustomAssetsImage(
                                          imagePath: controller.menuList[index]
                                              ["image"]!,
                                          height: 33.h)
                                    ],
                                  )),
                            ))));

                          },
                          itemCount: controller.menuList.length,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
