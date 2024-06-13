// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illaj_app/res/assets/images.dart';

class DoctorAvailabilityCard extends StatelessWidget {
  final String title;
  final String specilization;
  final String experience;
  final String image;
  final VoidCallback onTap;
  const DoctorAvailabilityCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.specilization,
    required this.experience,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // constraints: const BoxConstraints(maxHeight: double.infinity),

        alignment: Alignment.center,

        width: 70.w,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 3),
                  blurRadius: 5,
                  color: Colors.grey.withOpacity(0.2))
            ],
            borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image.isNotEmpty
                ? Container(
                    width: double.infinity,
                    height: 100.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.fitWidth),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r))),
                  )
                : Container(
                    width: double.infinity,
                    height: 70.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: const DecorationImage(
                            image: AssetImage(
                              ImageAssets.femaleDoctor,
                            ),
                            fit: BoxFit.contain),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r))),
                  ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 5.h),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          height: 1.2,
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      specilization,
                      style: TextStyle(
                          height: 1.2,
                          fontSize: 10.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    20.verticalSpace,
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Experience',
                            style: TextStyle(
                                height: 1.2,
                                fontSize: 10.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '$experience Years',
                            style: TextStyle(
                                height: 1.2,
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
