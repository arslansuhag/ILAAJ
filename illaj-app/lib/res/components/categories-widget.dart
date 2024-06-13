// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesWidget extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onTap;
  const CategoriesWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5.r),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 10.w),
        height: 70.h,
        width: 70.w,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 3),
                  blurRadius: 5,
                  color: Colors.grey.withOpacity(0.2))
            ],
            borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            5.verticalSpace,
            Text(
              title,
              textAlign: TextAlign.center,
              textScaleFactor: 0.8,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
