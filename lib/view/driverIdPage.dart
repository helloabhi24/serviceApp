import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/constant/constant.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/utils/showDialouge.dart';
import '../utils/customText.dart';
import '../widgets/homepageWidget.dart';
import 'driverDetailsPage.dart';

class DriverIdPage extends GetView<HomepageController> {
  const  DriverIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePageWidget.customeAppbar(context),
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
              child: ListTile(
                tileColor: KColors.red.withOpacity(0.1),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25))),
                dense: false,
                visualDensity: VisualDensity.compact,
                leading: Icon(Icons.person),
                title: const AppText(
                  text: "Driverid",
                  fontWeight: FontWeight.w600,
                ),
                subtitle: AppText(
                  text: controller.getDriverDetailList[index].name!,
                  color: KColors.green,
                ),
                trailing: const AppText(
                  text: "View details",
                  fontWeight: FontWeight.w600,
                ),
                onTap: () {
                  // viewDriverDetails(context, index);
                  Get.to(() => DriverDetailsPage(), arguments: index);
                },
              ));
        },
        itemCount: controller.getDriverDetailList.length,
      ),
    );
  }
}
