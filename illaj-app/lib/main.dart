import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/mongoDatabase/mongodb.dart';
import 'package:illaj_app/notification/notification-services.dart';
import 'package:illaj_app/res/colors/app-colors.dart';
import 'package:illaj_app/screens/mainsplashscreen.dart';
import 'package:illaj_app/screens/splash-screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // Handle background task here
    // Note: You can schedule your notification logic here based on your requirements
    return Future.value(true);
  });
}
late SharedPreferences prefs ;
MongoDataBase mongoDataBase = MongoDataBase();
NotificationServices notificationServices = NotificationServices();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
  await getApplicationDocumentsDirectory();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  NotificationServices notificationService = NotificationServices();
  notificationService.initializeNotifications();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Illaj',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.greenColor,
              ),
              useMaterial3: true,
            ),
            home: child,
          );
        },
        child: const mainsplashscreen());
  }
}
