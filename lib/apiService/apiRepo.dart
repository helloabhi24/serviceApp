import 'dart:convert';
import 'dart:io';
import 'dart:math';
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

  Future getDealerList(String id, String search) async {
    try {
      if (search.isEmpty) {
        var response = await _api.request
            .get(
              "https://admin.switchxenergy.com/api/get_user_with_battery?serviceUser_id=${id}",
              options: options,
            )
            .timeout(const Duration(seconds: 15));
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        var response = await _api.request
            .get(
              "https://admin.switchxenergy.com/api/get_user_with_battery?serviceUser_id=${id}&search=${search}",
              options: options,
            )
            .timeout(const Duration(seconds: 15));
        var responseBody = jsonDecode(response.data);
        return responseBody;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future getMobileToken() async {
    try {
      var response = await _api.request
          .get(
            "api/get_service_user_token",
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

  Future sendPushNotification(
      List pushToken, String msg, String senderName) async {
    // final body = {
    //   {
    //     "to": chatUser,
    //     "notification": {"title": chatUser, "body": msg}
    //   }
    // };
    try {
      var response =
          await _api.request.post("https://fcm.googleapis.com/fcm/send",
              options: Options(
                headers: {
                  HttpHeaders.contentTypeHeader: 'application/json',
                  HttpHeaders.authorizationHeader:
                      'key=AAAAsM--0hw:APA91bFoTs0pSyvMZq-1iZraN2d6JxDWAAO-4cYgmPGw_M5tHt2x-ddJEmppR5bWxcY1h6-G4AMlWTowgiuOt0MWap_u_G7UrhhggYEVebLXNv1simgILYOg2qNaVfqOsodpVkI6v5uP',
                },
              ),
              data: {
            "registration_ids": pushToken,
            "collapse_key": "type_a",
            "notification": {"title": senderName, "body": msg}
          });
      if (response.statusCode == 200) {
        print("yes send notification");
        // print(data);
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
    // return response.data;
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
    }
  }

  Future signInApi(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.SIGNIN, options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future serviceReport(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.SERVICEREPORT, options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future serviceUpdate(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.SERVICEUPDATE, options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future referDriver(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.REFERDRIVER, options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future status(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.STATUS, options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future attendenceMark(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.ATTENDENCEMARK, options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future batteryChargerProblem(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.BATTERYCHAGERPROBLEM,
              options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future getServiceUserList(String id) async {
    try {
      var response = await _api.request
          .get(
            "https://admin.switchxenergy.com/api/get_userlist?serviceUser_id=${id}",
            options: options,
          )
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future dealerList(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.DEALERLIST, options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future driverConnect(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.GETDRIVERCONNECT, options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future getDriverdetail(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.GETDRIVERDETAILS, options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future getDealerSurvey(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.DEALERSURVEY, options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future getUserList() async {
    try {
      var response = await _api.request
          .get(
            "https://admin.switchxenergy.com/api/get_userlist",
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

  Future addDriver(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.ADD_DRIVER, options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future addLocation(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.ADD_LOCATION, options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future userAttendence(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.USER_ATTENDANCE, options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future checkUserSurvay(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.CHECK_USER_SERVAY, options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future swapBatteryHistory(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.SWAP_BATTERY_HISTORY,
              options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future allocateBattery(Map<String, dynamic> data) async {
    try {
      var response = await _api.request
          .post(ServiceConstant.ALLOCATE_BATTERY, options: options, data: data)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);
        return responseBody;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorSnackbar(getError(e));
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
