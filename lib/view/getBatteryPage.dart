import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/constant/constant.dart';
import 'package:service/utils/customText.dart';

import '../controllers.dart/getBatteryController.dart';

class GetDriverConnectPage extends GetView<GetDriverConnectController> {
  const GetDriverConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: "DriverConnect",
        ),
        centerTitle: true,
        backgroundColor: KColors.persistentBlack,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
              elevation: 1,
              child: ListTile(
                tileColor: KColors.red.withOpacity(0.1),
                leading: CircleAvatar(child: Icon(Icons.person)),
                title: AppText(
                  text: controller.getDriverList[index].name,
                ),
                trailing: AppText(
                  text: controller.getDriverList[index].phone,
                ),
              ));
        },
        shrinkWrap: true,
        itemCount: controller.getDriverList.length,
      ),
    );
  }
}
