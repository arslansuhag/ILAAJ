import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/controllers/forgot-pass-controller.dart';
import 'package:illaj_app/mongoDatabase/apihelper.dart';
import 'package:illaj_app/res/colors/app-colors.dart';
import 'package:illaj_app/res/components/round-button.dart';
import 'package:illaj_app/res/components/custom-text-field-widget.dart';
import 'package:illaj_app/screens/login-screen.dart';

import '../utils/app-utils.dart';
import '../utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool obscureText = true;
  final ForgotPassController forgotPassController =
      Get.put(ForgotPassController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              const Text(
                'Forgot Password',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              20.verticalSpace,
              CustomTextFieldWidget(
                // onValidator: Utils.emailValidator,
                controller: forgotPassController.emailController.value,
                hintText: 'Email*',
              ),
              20.verticalSpace,
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
                  controller: forgotPassController.passController.value,
                  hintText: 'Password*'),
              20.verticalSpace,
              RoundButton(
                  width: double.infinity,
                  buttonColor: AppColors.greenColor,
                  title: 'Update Password',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (forgotPassController
                              .emailController.value.text.isEmpty ||
                          forgotPassController
                              .emailController.value.text.isEmpty) {
                        AppUtils.snackBar('Forgot Password', 'Enter All Fields',
                            const Duration(seconds: 2));
                      } else {
                        bool c = await ApiHelper.forgetpassword(
                            forgotPassController.emailController.value.text,
                            forgotPassController.passController.value.text);
                        if (c) {
                          Navigator.pop(context);
                          AppUtils.snackBar('Forgot Password',
                              'Password Updated', const Duration(seconds: 2));
                        }
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
