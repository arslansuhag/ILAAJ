import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:illaj_app/mongoDatabase/apihelper.dart';
import 'package:illaj_app/screens/login-screen.dart';

import '../utils/app-utils.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController().obs;
  final passController = TextEditingController().obs;
  final confirmPassController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final signUpFormKey = GlobalKey<FormState>().obs;

  RxBool doctor = false.obs;

  set setDoctor(bool val) {
    doctor.value = val;
    update();
  }

  Future<void> signUp() async {
    try {
      // Validate form fields
      if (signUpFormKey.value.currentState!.validate()) {
        // Get user input
        String name = nameController.value.text;
        String email = emailController.value.text;
        String phone = phoneController.value.text;
        String password = passController.value.text;

        bool b = await ApiHelper.registration(email, name, phone, password, "patient" , "","","", "active");
        if (b){
          AppUtils.snackBar('signup', "Signup successful", const Duration(seconds: 2));
          Get.off(() => const LoginScreen());
        } else {
          AppUtils.snackBar('signup', "Signup failed", const Duration(seconds: 2));
        }
      }
    } catch (e) {
      print("Error during signup: $e");
      // Handle error (show error message or perform other actions)
    }
  }
}
