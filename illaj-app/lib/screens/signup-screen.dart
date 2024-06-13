import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/controllers/signup-controller.dart';
import 'package:illaj_app/res/colors/app-colors.dart';
import 'package:illaj_app/res/components/round-button.dart';
import 'package:illaj_app/res/components/custom-text-field-widget.dart';
import 'package:illaj_app/screens/login-screen.dart';
import 'package:illaj_app/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool obscureText = true;
  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            key: signUpController.signUpFormKey.value,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  5.verticalSpace,
                  Row(
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                      5.horizontalSpace,
                      InkWell(
                        onTap: () {
                          Get.off(() => const LoginScreen());
                        },
                        child: Text(
                          'Sign In!',
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
                      onValidator: Utils.nameValidator,
                      controller: signUpController.nameController.value,
                      hintText: 'Name*'),
                  10.verticalSpace,
                  CustomTextFieldWidget(
                    onValidator: Utils.emailValidator,
                    controller: signUpController.emailController.value,
                    hintText: 'Email*',
                  ),
                  10.verticalSpace,
                  CustomTextFieldWidget(
                      onValidator: Utils.phoneValidator,
                      controller: signUpController.phoneController.value,
                      hintText: 'Phone*'),
                  10.verticalSpace,
                  CustomTextFieldWidget(
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
                      onValidator: Utils.passValidator,
                      controller: signUpController.passController.value,
                      hintText: 'Password*'),
                  10.verticalSpace,
                  CustomTextFieldWidget(
                      obscureText: true,
                      onValidator: Utils.passValidator,
                      controller: signUpController.confirmPassController.value,
                      hintText: 'Confirm Password*'),
                  12.verticalSpace,
                  20.verticalSpace,
                  RoundButton(
                      width: double.infinity,
                      buttonColor: AppColors.greenColor,
                      title: 'Sign Up',
                      onPressed: () async {
                        await signUpController.signUp();
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
