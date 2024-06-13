import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/controllers/doctor-signup-controller.dart';
import 'package:illaj_app/res/colors/app-colors.dart';
import 'package:illaj_app/res/components/round-button.dart';
import 'package:illaj_app/res/components/custom-text-field-widget.dart';
import 'package:illaj_app/screens/login-screen.dart';
import 'package:illaj_app/utils/utils.dart';

class DrSignUpScreen extends StatefulWidget {
  const DrSignUpScreen({super.key});

  @override
  State<DrSignUpScreen> createState() => _DrSignUpScreenState();
}

class _DrSignUpScreenState extends State<DrSignUpScreen> {
  bool obscureText = true;
  final DrSignUpController drSignUpController = Get.put(DrSignUpController());
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
            key: drSignUpController.formKey.value,
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
                      controller: drSignUpController.nameController.value,
                      hintText: 'Name*'),
                  10.verticalSpace,
                  CustomTextFieldWidget(
                    onValidator: Utils.emailValidator,
                    controller: drSignUpController.emailController.value,
                    hintText: 'Email*',
                  ),
                  10.verticalSpace,
                  CustomTextFieldWidget(
                      onValidator: Utils.nameValidator,
                      controller: drSignUpController.experienceController.value,
                      hintText: 'Experience*'),
                  10.verticalSpace,
                  CustomTextFieldWidget(
                      onValidator: Utils.nameValidator,
                      controller: drSignUpController.specController.value,
                      hintText: 'Specialization*'),
                  10.verticalSpace,
                  CustomTextFieldWidget(
                      onValidator: Utils.phoneValidator,
                      controller: drSignUpController.phoneController.value,
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
                      controller: drSignUpController.passController.value,
                      hintText: 'Password*'),
                  10.verticalSpace,
                  CustomTextFieldWidget(
                      onValidator: Utils.passValidator,
                      controller:
                          drSignUpController.confirmPassController.value,
                      hintText: 'Confirm Password*'),
                  10.verticalSpace,
                  CustomTextFieldWidget(
                      onValidator: Utils.nameValidator,
                      maxLines: 4,
                      controller: drSignUpController.desController.value,
                      hintText: 'Description*'),
                  12.verticalSpace,
                  20.verticalSpace,
                  RoundButton(
                      width: double.infinity,
                      buttonColor: AppColors.greenColor,
                      title: 'Sign Up',
                      onPressed: () {
                        drSignUpController.doctorSignUp();
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
