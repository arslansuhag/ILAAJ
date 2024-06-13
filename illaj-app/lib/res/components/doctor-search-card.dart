import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illaj_app/res/assets/images.dart';

class DoctorSearchCard extends StatelessWidget {
  final String title;
  const DoctorSearchCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.w, 0, 10.h, 10.w),
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 3),
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 4),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 70.h,
            width: 70.w,
            decoration: BoxDecoration(
                color: const Color(0xff2060c9),
                borderRadius: BorderRadius.circular(10.r),
                image: const DecorationImage(
                    image: AssetImage(ImageAssets.femaleDoctor),
                    fit: BoxFit.contain)),
          ),
          Padding(
            padding: EdgeInsets.all(8.h),
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
                      fontWeight: FontWeight.w500),
                ),
                3.verticalSpace,
                Text(
                  'Cardiologist (MBBS,FCPS)',
                  style: TextStyle(
                      height: 1.2,
                      fontSize: 10.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                5.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 10.h,
                      color: Colors.black,
                    ),
                    3.horizontalSpace,
                    Text(
                      '12:00pm - 4:00pm',
                      style: TextStyle(
                          height: 1.2,
                          fontSize: 9.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    10.horizontalSpace,
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 10.h,
                          color: Colors.black,
                        ),
                        3.horizontalSpace,
                        Text(
                          'New City Clinic',
                          style: TextStyle(
                              height: 1.2,
                              fontSize: 9.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
