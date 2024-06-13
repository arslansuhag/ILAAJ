// ignore_for_file: must_be_immutable

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/main.dart';
import 'package:illaj_app/mongoDatabase/apihelper.dart';
import 'package:illaj_app/res/colors/app-colors.dart';
import 'package:illaj_app/res/components/drawer-widget.dart';
import 'package:illaj_app/res/components/round-button.dart';
import 'package:illaj_app/screens/book-appointment-screen.dart';
import 'package:illaj_app/screens/bottom-navBar-screen.dart';
import 'package:illaj_app/screens/chatroom-screen.dart';

class DoctorDetailScreen extends StatefulWidget {
  var doctorId;

  DoctorDetailScreen({super.key, required this.doctorId});

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map doctorDetails={};

  @override
  void initState() {
    super.initState();
    fetchDoctorDetails();
  }

  Future<void> fetchDoctorDetails() async {
    doctorDetails = await ApiHelper.getoneuser(widget.doctorId);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerWidget(),
      appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Get.off(() => const BottomNavBarScreen());
                        },
                        child: const Icon(Icons.arrow_back))),
                20.horizontalSpace,
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        child: const Icon(Icons.menu))),
              ],
            ),
          ),
          centerTitle: true,
          title: doctorDetails != null
              ? Text(
                  doctorDetails['name'].toString(),
                  style: TextStyle(fontSize: 17.sp),
                )
              : Container()),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: doctorDetails != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 210.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        image: DecorationImage(
                            image: NetworkImage(
                              doctorDetails['img'].toString(),
                            ),
                            fit: BoxFit.cover)),
                  ),
                  10.verticalSpace,
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton.icon(
                        onPressed: () async {
                          Map c = await ApiHelper.registerchat(prefs.getString("id")!,
                              widget.doctorId);
                          if(c['status']){
                            Get.to(() => ChatRoomScreen(
                              id: c['message'],
                            ));
                          }
                        },
                        icon: Icon(
                          Icons.message,
                          size: 15.h,
                        ),
                        label: const Text('Message')),
                  ),
                  10.verticalSpace,
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Specialist',
                          style: TextStyle(
                              height: 1.2,
                              fontSize: 13.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          doctorDetails['specialization'].toString(),
                          style: TextStyle(
                              height: 1.2,
                              fontSize: 12.sp,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400),
                        ),
                        5.verticalSpace,
                        AnimatedRatingStars(
                          initialRating: int.parse(doctorDetails['itemrating'].toString()) /
                              int.parse(doctorDetails['itemuser'].toString()),
                          minRating: 0.0,
                          maxRating: 5.0,
                          filledColor: Colors.amber,
                          emptyColor: Colors.grey,
                          filledIcon: Icons.star,
                          halfFilledIcon: Icons.star_half,
                          emptyIcon: Icons.star_border,
                          onChanged: (double rating) {},
                          displayRatingValue: true,
                          interactiveTooltips: true,
                          customFilledIcon: Icons.star,
                          customHalfFilledIcon: Icons.star_half,
                          customEmptyIcon: Icons.star_border,
                          starSize: 10,
                          animationDuration: const Duration(milliseconds: 300),
                          animationCurve: Curves.easeInOut,
                          readOnly: true,
                        ),
                      ]),
                  10.verticalSpace,
                  Text(
                    'About',
                    style: TextStyle(
                        height: 1.2,
                        fontSize: 13.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  10.verticalSpace,
                  Text(
                    doctorDetails['description'].toString(),
                    // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    textDirection: TextDirection.ltr,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: TextStyle(
                        height: 1.2,
                        fontSize: 12.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400),
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     13.verticalSpace,
                      //     Text(
                      //       'Patients',
                      //       style: TextStyle(
                      //           height: 1.2,
                      //           fontSize: 12.sp,
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.w400),
                      //     ),
                      //     Text(
                      //       '2.7k',
                      //       style: TextStyle(
                      //           height: 1.2,
                      //           fontSize: 15.sp,
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.w600),
                      //     ),
                      //   ],
                      // ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          13.verticalSpace,
                          Text(
                            'Experience',
                            style: TextStyle(
                                height: 1.2,
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${doctorDetails['experience']}',
                            style: TextStyle(
                                height: 1.2,
                                fontSize: 15.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),

                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     13.verticalSpace,
                      //     Text(
                      //       'Reviews',
                      //       style: TextStyle(
                      //           height: 1.2,
                      //           fontSize: 12.sp,
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.w400),
                      //     ),
                      //     Text(
                      //       '2.05k',
                      //       style: TextStyle(
                      //           height: 1.2,
                      //           fontSize: 15.sp,
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.w600),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      13.verticalSpace,
                      Text(
                        'Location',
                        style: TextStyle(
                            height: 1.2,
                            fontSize: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        doctorDetails['location'].toString(),
                        style: TextStyle(
                            height: 1.2,
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  30.verticalSpace,
                  RoundButton(
                      buttonColor: AppColors.greenColor,
                      width: double.infinity,
                      title: 'Book an Appointment',
                      onPressed: () {
                        Get.to(() => BookAppointmentScreen(
                              doctorId: widget.doctorId,
                              doctorName: doctorDetails['name'],
                            ));
                      }),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
