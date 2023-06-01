import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:service/apiService/serviceConstant.dart';
import 'package:service/apiService/serviceRequest.dart';
import 'package:service/controllers.dart/batteryDetailPageController.dart';

import '../freezedFile/apiResult.dart';
import '../freezedFile/networkException.dart';
import '../utils/customshowInfo.dart';

class ApiRepo {
  final dio = Dio();
  final Api _api = Api();
  Options options = Options(
    headers: {
      HttpHeaders.authorizationHeader: 'YOUR KEY HERE',
    },
    contentType: 'application/json',
    responseType: ResponseType.json,
  );

  String getError(e) {
    return NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e));
  }

  Future getDealerList() async {
    try {
      var response = await _api.request
          .get(
            ServiceConstant.GETDEALERLIST,
            options: options,
          )
          .timeout(const Duration(seconds: 15));
      var responseBody = jsonDecode(response.data);
      return responseBody;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future fetchPowerOfBatteries(String bid) async {
    var response =
        await _api.request.post("http://battrack.electrifuel.com/batterydata/",
            options: Options(headers: {
              "X-Api-Key": "c7PgheG9.t1xlXJjrKeRI1P1Aq8mwTWHMYBE8EGt9",
              "Content-Type": "application/json"
            }),
            data: {
          "Bid": [bid],
          "data": [
            "soc",
            "soh",
            "cycles",
            "pv",
            "temperature",
            "cellVoltages",
            "location",
            "cva",
            "powermode"
          ]
        });
    return response.data;
  }

  BatteryDetailpageController batteryDetailpageController = Get.find();

  Future powerControlOfBatteries(String batteryId, bool isDischarge) async {
    print(batteryId);
    print(isDischarge);
    try {
      var response = await _api.request
          .post("http://battrack.electrifuel.com/batterypowercontrol/",
              options: Options(headers: {
                "X-Api-Key": "c7PgheG9.t1xlXJjrKeRI1P1Aq8mwTWHMYBE8EGt9",
                "Content-Type": "application/json"
              }),
              data: {"Bid": batteryId, "power": isDischarge});

      if (response.statusCode == 200) {
        if (isDischarge == true) {
          batteryDetailpageController.status.value = "Battery is On";
        } else {
          batteryDetailpageController.status.value = "Battery is Off";
        }
      } else {
        batteryDetailpageController.status.value = "Something Went Worng";
      }

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
      // DioExceptions.fromDioError(e);
      // print("no internet connection");
      // // customSnakebar("Something Went Wrong");
      // // customSnakebar(e.toString());
    }
  }

  // Future dischargingOfBatteries(String batteryId, bool isDischarge) async {
  //   print(batteryId);
  //   print(isDischarge);
  //   try {
  //     var response = await _api.request
  //         .post("http://battrack.electrifuel.com/batterypowercontrol/",
  //             options: Options(headers: {
  //               "X-Api-Key": "c7PgheG9.t1xlXJjrKeRI1P1Aq8mwTWHMYBE8EGt9",
  //               "Content-Type": "application/json"
  //             }),
  //             data: {"Bid": batteryId, "charging": isDischarge});

  //     if (response.statusCode == 200) {
  //       if (isDischarge == true) {
  //         batteryDetailpageController.status.value = "Battery is On";
  //       } else {
  //         batteryDetailpageController.status.value = "Battery is Off";
  //       }
  //     } else {
  //       batteryDetailpageController.status.value = "Something Went Worng";
  //     }

  //     return response.data;
  //   } catch (e) {
  //     batteryDetailpageController.status.value = "Something Went Worng";
  //   }
  // }
}
