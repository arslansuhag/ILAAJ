// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illaj_app/res/colors/app-colors.dart';

class DoctorHealthArticleCard extends StatelessWidget {
  String title;
  String description;
  String image;
  VoidCallback onDelete;
  VoidCallback onEdit;
  DoctorHealthArticleCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80.h
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      constraints: const BoxConstraints(maxHeight: double.infinity),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(0, 3),
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 4),
      ], color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(image, fit: BoxFit.cover,width: double.infinity,),
          Padding(
            padding: EdgeInsets.all(10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      height: 1.2,
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                3.verticalSpace,
                Text(
                  description,
                  // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      height: 1.2,
                      fontSize: 10.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: onEdit,
                      child: const Icon(
                        Icons.edit,
                        color: AppColors.blaclColor,
                      ),
                    ),
                    8.horizontalSpace,
                    GestureDetector(
                      onTap: onDelete,
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: AppColors.blaclColor,
                      ),
                    ),
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
