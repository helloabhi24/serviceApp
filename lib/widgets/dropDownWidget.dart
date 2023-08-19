import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:service/controllers.dart/homepageController.dart';

class DropDown extends StatefulWidget {
  DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    HomepageController homepageController = Get.find();
    return Obx(
      () => SizedBox(
        // decoration: BoxDecoration(
        //     border: Border.all(color: liftGreyColor.withOpacity(0.4)),
        //     borderRadius: BorderRadius.circular(5)),
        width: Get.width * 0.75,
        height: Get.height * 0.06,
        child: DropdownButton<String>(
          // dropdownColor: whiteColor,
          hint: Text(
            "  All",
            style: TextStyle(
                // color: blackColor,
                fontSize: 15.sp),
          ),
          // elevation: 0,
          // isExpanded: true,
          // Initial Value
          // value: cardManagementController.workingFliterCard.value,
          // value: _selectedItem,
          value: homepageController.userValue.value,
          // Down Arrow Icon

          // icon: Icon(
          //   Icons.arrow_drop_down,
          //   size: 30,
          //   color: orangeYellowColor,
          // ),

          // Array list of items
          items: homepageController.userList
              .map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value.name + " " + value.dealerId,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        value.name + " " + value.dealerId,
                        style: TextStyle(
                            // color: blackColor,
                            fontSize: 14.sp),
                      ),
                      // getwidth(context, 0.010),
                      // Text(
                      //   value.phonecode,
                      //   style: TextStyle(color: liftGreyColor),
                      // ),
                    ],
                  )),
              onTap: () async {
                // await cardManagementController.accountsBalance(
                //     value.id.toString(), "", "");

                // await cardManagementController.accountsBalance();
                // myOrderPageController.idofProduct.value = value.id;
                // await myOrderPageController.getOrderListwithDateType(
                //     myOrderPageController.idofProduct.value.toString());
                // walletTransactionController.idCard.value = value.id;
                // walletTransactionController.cardStatement(value.id.toString());

                // cardManagementController.idForBalance.value = value.id;
                // cardManagementController.omcValuee.value = null;
                // cardManagementController.productValuee.value = null;
                // cardManagementController.omcV.value = "";
                // cardManagementController.productV.value = "";
                print("This is the city id in card Statement");
                print(value.name);
                homepageController.dealerNameController.text = value.name;
                print("this is value of dealer in dropdown");
                print(value.name);
              },
            );
          }).toList(),

          onChanged: (String? newValue) {
            setState(() {
              homepageController.userValue.value = newValue!;
              // walletTransactionController.cardV.value = newValue!;
              print("This is new value of in onchanged");
              print(newValue);
              print(homepageController.userValue.value);
              // cardManagementController.cardValuee.value = newValue;
              // _selectedItem = newValue ?? "";
            });
          },
        ),
      ),
    );
  }
}

class DropDownForNewConnection extends StatefulWidget {
  DropDownForNewConnection({super.key});

  @override
  State<DropDownForNewConnection> createState() =>
      _DropDownForNewConnectionState();
}

class _DropDownForNewConnectionState extends State<DropDownForNewConnection> {
  @override
  Widget build(BuildContext context) {
    HomepageController homepageController = Get.find();
    return Obx(
      () => SizedBox(
        // decoration: BoxDecoration(
        //     border: Border.all(color: liftGreyColor.withOpacity(0.4)),
        //     borderRadius: BorderRadius.circular(5)),
        width: Get.width * 0.60,
        height: Get.height * 0.06,
        child: DropdownButton<String>(
          // dropdownColor: whiteColor,
          hint: Text(
            "  All",
            style: TextStyle(
                // color: blackColor,
                fontSize: 15.sp),
          ),
          // elevation: 0,
          // isExpanded: true,
          // Initial Value
          // value: cardManagementController.workingFliterCard.value,
          // value: _selectedItem,
          value: homepageController.userValue.value,
          // Down Arrow Icon

          // icon: Icon(
          //   Icons.arrow_drop_down,
          //   size: 30,
          //   color: orangeYellowColor,
          // ),

          // Array list of items
          items: homepageController.userList
              .map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value.name + " " + value.dealerId,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        value.name + " " + value.dealerId,
                        style: TextStyle(
                            // color: blackColor,
                            fontSize: 11.sp),
                      ),
                      // getwidth(context, 0.010),
                      // Text(
                      //   value.phonecode,
                      //   style: TextStyle(color: liftGreyColor),
                      // ),
                    ],
                  )),
              onTap: () async {
                // await cardManagementController.accountsBalance(
                //     value.id.toString(), "", "");

                // await cardManagementController.accountsBalance();
                // myOrderPageController.idofProduct.value = value.id;
                // await myOrderPageController.getOrderListwithDateType(
                //     myOrderPageController.idofProduct.value.toString());
                // walletTransactionController.idCard.value = value.id;
                // walletTransactionController.cardStatement(value.id.toString());

                // cardManagementController.idForBalance.value = value.id;
                // cardManagementController.omcValuee.value = null;
                // cardManagementController.productValuee.value = null;
                // cardManagementController.omcV.value = "";
                // cardManagementController.productV.value = "";
                print("This is the city id in card Statement");
                print(value.name);
                // homepageController.dealerNameController.text = value.name;
                homepageController.dealerID.value = value.id;
                print("this is value of dealer in dropdown");
                print(value.name);
              },
            );
          }).toList(),

          onChanged: (String? newValue) {
            setState(() {
              homepageController.userValue.value = newValue!;
              // walletTransactionController.cardV.value = newValue!;
              print("This is new value of in onchanged");
              print(newValue);
              print(homepageController.userValue.value);
              // cardManagementController.cardValuee.value = newValue;
              // _selectedItem = newValue ?? "";
            });
          },
        ),
      ),
    );
  }
}
