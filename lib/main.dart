import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:service/routes.dart/appPage.dart';
import 'package:service/view/spalshScreen.dart';
import 'package:uuid/uuid.dart';
import 'Bindings/controllersBindings.dart';

var uuid = const Uuid();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    return 
      ScreenUtilInit(
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
              ),child:const SplashScreen()
    );
          
    
  }
}
