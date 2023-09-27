import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:service/controllers.dart/homepageController.dart';

import '../view/chatPage.dart';

class NotificationSetting extends GetView<HomepageController> {
  // HomepageController _homepageController = Get.put(HomepageController());

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> getFirebaseMessegingToken() async {
    NotificationSettings settings = await messaging.requestPermission();
    // print('User granted permission: ${settings.authorizationStatus}');
    // String? token = await messaging.getToken();

    String? token = await messaging.getToken();
    controller.pushToken.value = token!;
    // .then((value) {
    //   if (value != null) {
    //     print("this is the token dsfasdfsdafs");
    //     print(value);
    //     debugPrint('Push Token: $value');
    //   }
    // }
    // );
    print("this is the value of token");
    print(token);
    print(settings.authorizationStatus);
  }

  void initLocalNotificaitons(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payload) {
        handleMethod(context, message);
      },
    );
  }

  void isTokenRefershed() {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(1000000).toString(),
        'High Importance Notifications',
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: 'channel description',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker');
    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) {
      // print("this is the msg");
      // if (kDebugMode) {
      //   print(event.notification!.title.toString());
      //   print(event.notification!.body.toString());
      // }
      initLocalNotificaitons(context, event);
      showNotification(event);
    });
  }

  Future<void> setupInteactMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMethod(context, initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMethod(context, event);
    });
  }

  void handleMethod(BuildContext context, RemoteMessage message) {
    Get.to(ChatsWithPerson());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
