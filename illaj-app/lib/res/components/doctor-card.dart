// ignore_for_file: deprecated_member_use

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illaj_app/res/assets/images.dart';
import 'package:illaj_app/res/colors/app-colors.dart';

class DoctorCard extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String specialization;
  final String experience;
  final String image;
  final String itemrating;
  final String itemuser;
  final String description;
  const DoctorCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.specialization,
    required this.experience,
    required this.image,
    required this.itemrating,
    required this.itemuser,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(maxHeight: double.infinity),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 10.w),
        // height: 70.h,
        width: 270.w,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 3),
                  blurRadius: 5,
                  color: Colors.grey.withOpacity(0.2))
            ],
            borderRadius: BorderRadius.circular(12.r)),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            image.isNotEmpty
                ? Container(
                    margin: EdgeInsets.only(right: 20.w),
                    height: 160.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover)),
                  )
                : Container(
                    margin: EdgeInsets.only(right: 20.w),
                    height: 160.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        image: const DecorationImage(
                            image: AssetImage(ImageAssets.deafultUser),
                            fit: BoxFit.cover)),
                  ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        height: 1.2,
                        fontSize: 13.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    specialization,
                    style: TextStyle(
                        height: 1.2,
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  12.verticalSpace,
                  AnimatedRatingStars(
                    initialRating: int.parse(itemrating) / int.parse(itemuser),
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
                  10.verticalSpace,
                  Text(
                    description,
                    maxLines: 3,
                    textDirection: TextDirection.ltr,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(
                        height: 1.2,
                        fontSize: 10.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  10.verticalSpace,
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
                        experience,
                        style: TextStyle(
                            height: 1.2,
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
