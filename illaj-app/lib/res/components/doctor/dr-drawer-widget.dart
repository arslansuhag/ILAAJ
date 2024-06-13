// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:illaj_app/controllers/dr-profile-controller.dart';
import 'package:illaj_app/mongoDatabase/mongodb.dart';
import 'package:illaj_app/res/assets/images.dart';
import 'package:illaj_app/res/colors/app-colors.dart';
import 'package:illaj_app/screens/doctor/dr-profile-screen.dart';
import 'package:illaj_app/screens/termsconditions.dart';

import '../../../main.dart';
import '../../../mongoDatabase/apihelper.dart';
import '../../../screens/aboutus.dart';
import '../../../screens/doctor/doctor-appointment-screen.dart';
import '../../../screens/needhelp.dart';
import '../../../screens/profile-screen.dart';

class DoctorDrawerWidget extends StatefulWidget {
  const DoctorDrawerWidget({super.key});

  @override
  State<DoctorDrawerWidget> createState() => _DoctorDrawerWidgetState();
}

class _DoctorDrawerWidgetState extends State<DoctorDrawerWidget> {
  final DrProfileController drProfileController =
      Get.put(DrProfileController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.blaclColor,
      child: ListView(
        children: [
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
              height: 150.h,
              decoration: const BoxDecoration(
                color: AppColors.blaclColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  20.verticalSpace,
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.white,
                        ),
                      ),
                      5.horizontalSpace,
                      Text(
                        'PROFILE',
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                            fontFamily: 'Bold'),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  FutureBuilder(
                    future: ApiHelper.getoneuser(prefs.getString("id")!),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.hasData){
                        if(snapshot.data.toString() == '[]'){
                          return const Center(
                            child: Text("No Data"),
                          );
                        } else {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              snapshot.data['img'] != ""
                                  ? CircleAvatar(
                                radius: 38.r,
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                    snapshot.data['img']),
                              )
                                  : CircleAvatar(
                                radius: 38.r,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                const AssetImage(ImageAssets.deafultUser),
                              ),
                              8.horizontalSpace,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data['name'],
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.white,
                                        fontFamily: 'Bold'),
                                  ),
                                  Text(
                                    snapshot.data['email'],
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.white,
                                        fontFamily: 'Bold'),
                                  ),
                                  // Text(
                                  //   'Registered Since Nov 2023',
                                  //   style: TextStyle(
                                  //       fontSize: 12.sp,
                                  //       fontWeight: FontWeight.w400,
                                  //       color: AppColors.yellow,
                                  //       fontFamily: 'Bold'),
                                  // ),
                                ],
                              ),
                            ],
                          );
                        }
                      } else if(snapshot.hasError){
                        return const Icon(Icons.error,);
                      } else{
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              )),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                  color: AppColors.accentGreen,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r))),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => DoctorAppointmentScreen(d: false,));
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          ImageAssets.doctorIcon,
                          color: Colors.black,
                        ),
                        8.horizontalSpace,
                        Text(
                          'Appointments',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  6.verticalSpace,
                  const Divider(
                    thickness: 1.5,
                    color: Color(0xffEFEDE9),
                  ),
                  6.verticalSpace,
                  InkWell(
                    onTap: () {
                      Get.to(() => const DrProfileScreen());
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_history_outlined,
                          color: Colors.black,
                        ),
                        8.horizontalSpace,
                        Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  6.verticalSpace,
                  const Divider(
                    thickness: 1.5,
                    color: Color(0xffEFEDE9),
                  ),
                  6.verticalSpace,
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person_add_alt_outlined,
                          color: Colors.black,
                        ),
                        8.horizontalSpace,
                        Text(
                          'Invite Friends',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  6.verticalSpace,
                  const Divider(
                    thickness: 1.5,
                    color: Color(0xffEFEDE9),
                  ),
                  6.verticalSpace,
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                        8.horizontalSpace,
                        Text(
                          'My Settings',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  6.verticalSpace,
                  const Divider(
                    thickness: 1.5,
                    color: Color(0xffEFEDE9),
                  ),
                  6.verticalSpace,
                  InkWell(
                    onTap: () async {
                      Get.back();
                      await mongoDataBase.logout();
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                        8.horizontalSpace,
                        Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  3.verticalSpace,
                  const Divider(
                    thickness: 1.5,
                    color: Color(0xffEFEDE9),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.r),
              decoration: const BoxDecoration(
                color: AppColors.yellow,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.verticalSpace,
                  InkWell(
                    onTap: () {
                      Get.to(() => NeedHelp());
                    },
                    child: Text(
                      'Need Help?',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  3.verticalSpace,
                  const Divider(
                    thickness: 0.5,
                    color: AppColors.blaclColor,
                  ),
                  3.verticalSpace,
                  InkWell(
                    onTap: () {
                      Get.to(() => AboutUs());
                    },
                    child: Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  3.verticalSpace,
                  const Divider(
                    thickness: 0.5,
                    color: AppColors.blaclColor,
                  ),
                  3.verticalSpace,
                  InkWell(
                    onTap: () {
                      Get.to(() => Terms());
                    },
                    child: Text(
                      'Terms and Conditions',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // 5.verticalSpace,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
