import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:illaj_app/screens/admin/admin.dart';
import 'package:illaj_app/screens/bottom-navBar-screen.dart';
import 'package:illaj_app/screens/doctor/bottom-nav-screen.dart';
import 'package:illaj_app/utils/app-utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mongoDatabase/apihelper.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController().obs;
  final passController = TextEditingController().obs;
  var signinFormKey = GlobalKey<FormState>().obs;
  RxBool doctor = false.obs;

  set setDoctor(bool val) {
    doctor.value = val;
    update();
  }

  Future<void> login() async {
    try {
      // Get user input
      String email = emailController.value.text;
      String password = passController.value.text;

      if(email == "admin@gmail.com" && password == "123456"){
        Get.to(() => const Admin());
      } else {
        var user = await ApiHelper.login(email, password);
        if (user.toString() != "{}") {
          if(user['status'] == "active") {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('type', user['type']);
            prefs.setString('name', user['name']);
            prefs.setBool('loggedIn', true);
            prefs.setString('id', user['_id']);
            prefs.setString('itemrating', user['itemrating']);
            prefs.setString('itemuser', user['itemuser']);
            // User found, navigate to the next screen (e.g., home screen)
            AppUtils.snackBar(
                'Login', 'Login successful!', const Duration(seconds: 2));
            if (user['type'] == 'patient') {
              Get.to(() => const BottomNavBarScreen());
            } else {
              Get.to(() => const DoctorBottomNavScreen());
            }

            print("Login successful!");
          } else {
            AppUtils.snackBar('Login', 'Account not active',
                const Duration(seconds: 3));
          }
        } else {
          AppUtils.snackBar('Login', 'Invalid credentials. Please try again.',
              const Duration(seconds: 3));
          print("Invalid credentials. Please try again.");
        }
      }
    } catch (e) {
      print("Error during login: $e");
    }
  }

  void checkLoginStatus() async {
    print("Checking login status");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('loggedIn');
    String? type = prefs.getString('type');
    if (isLoggedIn != null && isLoggedIn) {
      // print("Already logged in, navigating to HomeScreen");
      if (type == "patient") {
        Get.off(() => const BottomNavBarScreen());
      } else if (type == "doctor") {
        Get.off(() => const DoctorBottomNavScreen());
      }
    }
  }
}
