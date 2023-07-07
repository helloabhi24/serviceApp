
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:service/constant/constant.dart';
import 'package:service/constant/sizeHelper.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/utils/customText.dart';
import 'package:service/utils/textExtension.dart';

class ServiceReportPage extends GetView<HomepageController> {
  const ServiceReportPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const AppText(text: "ServiceReport",),centerTitle: true,backgroundColor: KColors.persistentBlack,),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            getheight(context, 0.010),
             serviceFormfileds(),
             getheight(context, 0.010),
             Expanded(
               child: SizedBox(
                 child: AnimationLimiter(
                   child: ListView.builder(itemBuilder: (context , index){
                                 return  AnimationConfiguration.staggeredList(position: index, child: SlideAnimation(child: ScaleAnimation(
                                  duration: Duration(milliseconds: 3000),curve: Curves.fastLinearToSlowEaseIn,
                                  child: serviceReportWidget(index)) , verticalOffset: -250,) , delay: Duration(milliseconds: 200),);
                                 
                   },itemCount: controller.serviceReportList.length,shrinkWrap: true, physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),),
                 ),
               ),
             )
          ],
        ),
      ),
    );
  }


    serviceReportWidget(int index){
      return Obx(()=>
       Container(margin: const EdgeInsets.all(3),
                padding: EdgeInsets.all(8.sp),
                  height: Get.height*0.17,width: Get.width*0.90, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: KColors.grey.withOpacity(0.3)),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        controller.serviceReportList[index].user![0].name!.f16w6(textColor: KColors.persistentBlack , fontWeight: FontWeight.w600),
                        "SE012".f16w6(textColor: KColors.persistentBlack,fontWeight: FontWeight.w600),
                      ],),
                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        controller.serviceReportList[index].user![0].phone!.f14w4(textColor: KColors.persistentBlack , fontSize: 16.sp , fontWeight: FontWeight.w500),
                        controller.serviceReportList[index].serviceUser!.f16w6(textColor: KColors.persistentBlack, fontWeight: FontWeight.w600),
                      ],),
                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        controller.serviceReportList[index].date.toString().f12w4(textColor: KColors.persistentBlack),
                        controller.serviceReportList[index].status!.f18w6(textColor: KColors.red),
                      ],),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        controller.serviceReportList[index].status!.f18w6(textColor: KColors.red) , Switch(activeColor: KColors.green,
                          value:controller.serviceReportList[index].status=="Pending"?false:true ,onChanged: (v)async{
                           controller.isswitch.value = !controller.isswitch.value;
                          await controller.serviceUpdate(controller.serviceReportList[index].id!, v==true?"Closed":"Pending");
                           controller.serviceReport();
                         })
                      ],)
                    ],
                  ),),
      );
    }


   serviceFormfileds(){
    return TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: getVerticalSize(10) , horizontal: getHorizontalSize(10)),
                hintText: "Search.....",
                hintStyle:
               TextStyle(color: KColors.persistentBlack, fontSize: 15.sp),
               suffixIcon: const Icon(Icons.search , color: KColors.persistentBlack,),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide:
                const BorderSide(color: KColors.persistentBlack, width: .4),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide:
                const BorderSide(color: KColors.persistentBlack, width: .4),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.red, width: .4),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.black, width: .4),
          ),
              ),
             );
   }


}