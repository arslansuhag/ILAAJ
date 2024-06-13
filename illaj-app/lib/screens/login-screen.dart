// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/controllers/login-controller.dart';
import 'package:illaj_app/res/colors/app-colors.dart';
import 'package:illaj_app/res/components/round-button.dart';
import 'package:illaj_app/res/components/custom-text-field-widget.dart';
import 'package:illaj_app/screens/doctor/doctor-sign-up-screen.dart';
import 'package:illaj_app/screens/forgot-password.dart';
import 'package:illaj_app/screens/signup-screen.dart';
import 'package:illaj_app/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());
  bool obscureText = true;
  @override
  void initState() {
    super.initState();
    loginController.checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Pop all routes until reaching the root route
        while (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        // Close the app
        return true;
      },
      child: GestureDetector(
        onTap: () async {
          var currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
          } else {}
        },
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20.r),
            child: Form(
              key: loginController.signinFormKey.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Obx(
                  //         () => ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             backgroundColor:
                  //                 loginController.doctor.value == true
                  //                     ? AppColors.greenColor
                  //                     : Colors.grey.withOpacity(0.5),
                  //           ),
                  //           onPressed: () {
                  //             loginController.doctor.value = true;
                  //             loginController.update();
                  //           },
                  //           child: const Text(
                  //             'Doctor',
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     15.horizontalSpace,
                  //     Expanded(
                  //       child: Obx(
                  //         () => ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             backgroundColor:
                  //                 loginController.doctor.value == false
                  //                     ? AppColors.greenColor
                  //                     : Colors.grey.withOpacity(0.5),
                  //           ),
                  //           onPressed: () {
                  //             loginController.setDoctor = false;
                  //             loginController.update();
                  //           },
                  //           child: const Text(
                  //             'Patient',
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  10.verticalSpace,
                  const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  5.verticalSpace,
                  Row(
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                      5.horizontalSpace,
                      InkWell(
                        onTap: () {
                          loginController.doctor.value == false
                              ? Get.to(() => const SignUpScreen())
                              : Get.to(() => const DrSignUpScreen());
                        },
                        child: Text(
                          'Sign up!',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.greenColor),
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  CustomTextFieldWidget(
                    onValidator: Utils.emailValidator,
                    controller: loginController.emailController.value,
                    hintText: 'Email*',
                  ),
                  10.verticalSpace,
                  CustomTextFieldWidget(
                      onValidator: Utils.passValidator,
                      controller: loginController.passController.value,
                      obscureText: obscureText,
                      suffixTap: InkWell(
                        onTap: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: Icon(
                          obscureText
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined,
                          color: Colors.black,
                        ),
                      ),
                      hintText: 'Password*'),
                  12.verticalSpace,
                  InkWell(
                    onTap: () {
                      Get.to(() => const ForgotPasswordScreen());
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blaclColor),
                    ),
                  ),
                  20.verticalSpace,
                  RoundButton(
                      width: double.infinity,
                      buttonColor: AppColors.greenColor,
                      title: 'Sign In',
                      onPressed: () {
                        if (loginController.signinFormKey.value.currentState!
                            .validate()) {
                          Utils.setDoctor(loginController.doctor.value);
                          if (loginController.doctor.value) {
                            loginController.login();
                          } else {
                            loginController.login();
                          }
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
