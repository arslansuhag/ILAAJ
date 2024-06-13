import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/controllers/login-controller.dart';
import 'package:illaj_app/res/assets/images.dart';
import 'package:illaj_app/res/colors/app-colors.dart';
import 'package:illaj_app/res/components/round-button.dart';
import 'package:illaj_app/screens/doctor/doctor-sign-up-screen.dart';
import 'package:illaj_app/screens/login-screen.dart';
import 'package:illaj_app/screens/signup-screen.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LoginController loginController = Get.put(LoginController());
  @override
  initState() {
    super.initState();
    p();
    loginController.checkLoginStatus();
  }

  Future<void> p() async {
    await Permission.scheduleExactAlarm.request();
    await Permission.notification.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(ImageAssets.splash),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            70.verticalSpace,
            Center(
              child: Image.asset(
                ImageAssets.doctorLogo,
                height: 150.h,
                width: 150.h,
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '𝗜𝗟A𝗔𝗝 ',
                    style: TextStyle(
                        fontSize: 30.sp,
                        letterSpacing: 2.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'is Ultimate solution to all \nyour health issues!',
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 13.sp,
                        letterSpacing: 2.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            190.verticalSpace,
            Expanded(
                flex: 2,
                child: Center(
                  child: Container(
                    // height: 400.h,
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r),
                        )),
                    constraints:
                        const BoxConstraints(maxHeight: double.infinity),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome to ',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'ILAAJ!',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: AppColors.greenColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        12.verticalSpace,
                        RoundButton(
                            width: double.infinity,
                            title: 'Sign Up',
                            buttonColor: AppColors.accentGreen,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Colors.white,
                                    child: Container(
                                      padding: EdgeInsets.all(12.r),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.r),
                                        color: Colors.white
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Sign Up', style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold
                                          ),),
                                          20.verticalSpace,
                                          RoundButton(
                                              width: double.infinity,
                                              buttonColor: AppColors.accentGreen,
                                              textColor: AppColors.white,
                                              title: 'patient',
                                              onPressed: () {
                                                Get.to(() => const SignUpScreen());
                                              }),
                                          12.verticalSpace,
                                          RoundButton(
                                              width: double.infinity,
                                              buttonColor: AppColors.accentGreen,
                                              textColor: AppColors.white,
                                              title: 'Doctor',
                                              onPressed: () {
                                                Get.to(() => const DrSignUpScreen());
                                              }),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                        12.verticalSpace,
                        RoundButton(
                            width: double.infinity,
                            buttonColor: AppColors.white,
                            textColor: AppColors.blaclColor,
                            title: 'Log In',
                            onPressed: () {
                              Get.to(() => const LoginScreen());
                            }),
                        12.verticalSpace,
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
