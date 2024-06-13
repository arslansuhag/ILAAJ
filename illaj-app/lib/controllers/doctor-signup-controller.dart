import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:illaj_app/screens/login-screen.dart';

import '../mongoDatabase/apihelper.dart';
import '../utils/app-utils.dart';

class DrSignUpController extends GetxController {
  final emailController = TextEditingController().obs;
  final passController = TextEditingController().obs;
  final confirmPassController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final experienceController = TextEditingController().obs;
  final specController = TextEditingController().obs;
  final desController = TextEditingController().obs;
  final formKey = GlobalKey<FormState>().obs;

  RxBool doctor = false.obs;

  set setDoctor(bool val) {
    doctor.value = val;
    update();
  }

  Future<void> doctorSignUp() async {
    try {
      // Validate form fields
      if (formKey.value.currentState!.validate()) {
        // Get user input
        String name = nameController.value.text;
        String email = emailController.value.text;
        String phone = phoneController.value.text;
        String password = passController.value.text;
        String experience = experienceController.value.text;
        String specialization = specController.value.text;
        String description = desController.value.text;

        bool b = await ApiHelper.registration(email, name, phone, password, "doctor",
            experience,specialization,description,"noactive");
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
