

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/constant/constant.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/utils/showDialouge.dart';
import '../utils/customText.dart';
import '../widgets/homepageWidget.dart';

class DriverIdPage extends  GetView<HomepageController>{
  const DriverIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: HomePageWidget.customeAppbar(context),
      body: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return   Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(tileColor: KColors.red.withOpacity(0.1),
              
                dense: false,
                visualDensity: VisualDensity.compact,
                title: const AppText(text: "Driverid",),
                subtitle:  AppText(text: controller.getDriverDetailList[index].name!,),
                trailing: const AppText(text: "View details",),
                onTap: (){
              
                viewDriverDetails(context , index);
                },
              )
            );
          },
          itemCount: controller.getDriverDetailList.length,
        ),
    );
  }
}