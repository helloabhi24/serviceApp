import 'dart:async';
import 'dart:math';

import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:service/controllers.dart/homepageController.dart';
import 'package:service/routes.dart/appPage.dart';
import 'package:service/view/spalshScreen.dart';
import 'package:uuid/uuid.dart';
import 'Bindings/controllersBindings.dart';
import 'model/notificationClass.dart';

var uuid = const Uuid();

@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    print("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }
  print('[BackgroundFetch] Headless event received.');
  // Do your work here...
  BackgroundFetch.finish(taskId);
}

NotificationSetting notificationSetting = NotificationSetting();

// FirebaseMessaging messaging = FirebaseMessaging.instance;

// Future<void> getFirebaseMessegingToken() async {
//   NotificationSettings settings = await messaging.requestPermission();
//   // print('User granted permission: ${settings.authorizationStatus}');
//   String? token = await messaging.getToken();
//   // .then((value) {
//   //   if (value != null) {
//   //     print("this is the token dsfasdfsdafs");
//   //     print(value);
//   //     debugPrint('Push Token: $value');
//   //   }
//   // }
//   // );
//   print("this is the value of token");
//   print(token);
//   print(settings.authorizationStatus);
// }

// void isTokenRefershed() {
//   messaging.onTokenRefresh.listen((event) {
//     event.toString();
//   });
// }

// void firebaseInit() {
//   FirebaseMessaging.onMessage.listen((event) {
//     print("this is the msg");
//     print(event.notification!.title.toString());
//     print(event.notification!.body.toString());
//   });
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool _enabled = true;
  int _status = 0;
  List<DateTime> _events = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
    notificationSetting.isTokenRefershed();
    notificationSetting.getFirebaseMessegingToken();
    notificationSetting.firebaseInit(context);
    notificationSetting.setupInteactMessage(context);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    // HomepageController homepageController = Get.find();
    int status = await BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 15,
            stopOnTerminate: false,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.NONE), (String taskId) async {
      // <-- Event handler
      // This is the fetch-event callback.
      print("[BackgroundFetch] Event received $taskId");
      setState(() {
        _events.insert(0, new DateTime.now());
      });
      // Timer.periodic(Duration(seconds: 10),
      //     (Timer t) async => await homepageController.getLocationFrequently());
      // IMPORTANT:  You must signal completion of your task or the OS can punish your app
      // for taking too long in the background.
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      // <-- Task timeout handler.
      // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
      print("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
      BackgroundFetch.finish(taskId);
    });
    print('[BackgroundFetch] configure success: $status');
    setState(() {
      _status = status;
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  void _onClickEnable(enabled) {
    setState(() {
      _enabled = enabled;
    });
    if (enabled) {
      BackgroundFetch.start().then((int status) {
        print('[BackgroundFetch] start success: $status');
      }).catchError((e) {
        print('[BackgroundFetch] start FAILURE: $e');
      });
    } else {
      BackgroundFetch.stop().then((int status) {
        print('[BackgroundFetch] stop success: $status');
      });
    }
  }

  void _onClickStatus() async {
    int status = await BackgroundFetch.status;
    print('[BackgroundFetch] status: $status');
    setState(() {
      _status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => GetMaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              initialBinding: GetXbindings(),
              getPages: AppPage.routes,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: child,
            ),
        child: const SplashScreen());
  }
}
