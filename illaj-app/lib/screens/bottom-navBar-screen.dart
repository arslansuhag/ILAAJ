// ignore_for_file: deprecated_member_use

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:illaj_app/controllers/nav-bar-controller.dart';
import 'package:illaj_app/res/assets/images.dart';
import 'package:illaj_app/res/colors/app-colors.dart';
import 'package:illaj_app/screens/appointment-screen.dart';
import 'package:illaj_app/screens/doctors-screen.dart';
import 'package:illaj_app/screens/home-screen.dart';
import 'package:illaj_app/screens/login-screen.dart';
import 'package:illaj_app/screens/profile-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final NavBarController navBarController = Get.put(NavBarController());

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    DoctorsScreen(),
    AppointmentScreen(),
    ProfileScreen(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    print("Checking login status");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('loggedIn');

    if (isLoggedIn == null || !isLoggedIn) {
      prefs.setBool('loggedIn', false);

      Get.off(() => const LoginScreen());
    }
  }

  Widget build(BuildContext context) {
    print('rebuild');
    return WillPopScope(
      onWillPop: () async {
        // Pop all routes until reaching the root route
        while (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
        // Close the app
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Obx(
            () => _widgetOptions.elementAt(navBarController.currentIndex.value),
          ),
          bottomNavigationBar: Obx(() {
            return BottomNavyBar(
              backgroundColor: AppColors.blaclColor,
              itemCornerRadius: 10.r,
              containerHeight: 50.h,
              selectedIndex: navBarController.currentIndex.value,
              onItemSelected: (index) {
                navBarController.setCurrentIndex(index);
              },
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                    title: const Text(
                      'Home',
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                    icon: const Icon(
                      Icons.home,
                      color: AppColors.white,
                    )),
                BottomNavyBarItem(
                    title: const Text(
                      'Doctors',
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                    icon: SvgPicture.asset(
                      ImageAssets.doctorSvg,
                      height: 20.h,
                      color: AppColors.white,
                    )),
                BottomNavyBarItem(
                    title: const Text(
                      'Appointment',
                      style: TextStyle(fontSize: 13, color: AppColors.white),
                    ),
                    icon: SvgPicture.asset(
                      ImageAssets.appointmentIcon,
                      height: 20.h,
                      color: AppColors.white,
                    )),
                BottomNavyBarItem(
                    title: const Text(
                      'Profile',
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                    icon: const Icon(
                      Icons.person,
                      color: AppColors.white,
                    )),
              ],
            );
          })),
    );
  }
}
