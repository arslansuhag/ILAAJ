// ignore_for_file: deprecated_member_use

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:illaj_app/controllers/nav-bar-controller.dart';
import 'package:illaj_app/res/assets/images.dart';
import 'package:illaj_app/res/colors/app-colors.dart';
import 'package:illaj_app/screens/doctor/doctor-appointment-screen.dart';
import 'package:illaj_app/screens/doctor/doctor-chat-screen.dart';
import 'package:illaj_app/screens/doctor/doctor-health-articles-screen.dart';
import 'package:illaj_app/screens/doctor/dr-profile-screen.dart';
import 'package:illaj_app/screens/login-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorBottomNavScreen extends StatefulWidget {
  const DoctorBottomNavScreen({super.key});

  @override
  State<DoctorBottomNavScreen> createState() => _DoctorBottomNavScreenState();
}

class _DoctorBottomNavScreenState extends State<DoctorBottomNavScreen> {
  final NavBarController navBarController = Get.put(NavBarController());

  static final List<Widget> _widgetOptions = <Widget>[
    DoctorAppointmentScreen(),
    const DoctorHealthArticles(),
    const DoctorChatScreen(),
    const DrProfileScreen()
  ];

  void initState() {
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
        }
        // Close the app
        return true;
      },
      child: Scaffold(
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
                // BottomNavyBarItem(
                //     title: const Text(
                //       'Home',
                //       style: TextStyle(
                //         color: Color(0xff2060c9),
                //       ),
                //     ),
                //     icon: const Icon(
                //       Icons.home,
                //       color: Color(0xff2060c9),
                //     )),
                // BottomNavyBarItem(
                //     title: const Text(
                //       'Doctors',
                //       style: TextStyle(
                //         color: Color(0xff2060c9),
                //       ),
                //     ),
                //     icon: SvgPicture.asset(
                //       ImageAssets.doctorSvg,
                //       height: 20.h,
                //       color: const Color(0xff2060c9),
                //     )),
                BottomNavyBarItem(
                    title: Text(
                      'Appointment',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.white,
                      ),
                    ),
                    icon: SvgPicture.asset(
                      ImageAssets.appointmentIcon,
                      height: 20.h,
                      color: AppColors.white,
                    )),
                BottomNavyBarItem(
                    title: Text(
                      'HealthArticles',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.white,
                      ),
                    ),
                    icon: Icon(
                      Icons.article_outlined,
                      size: 20.h,
                      color: AppColors.white,
                    )),
                BottomNavyBarItem(
                    title: Text(
                      'Chats',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.white,
                      ),
                    ),
                    icon: Icon(
                      Icons.chat,
                      size: 20.h,
                      color: AppColors.white,
                    )),
                BottomNavyBarItem(
                    title: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 11.sp,
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
