import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illaj_app/res/assets/images.dart';
import 'package:illaj_app/res/colors/app-colors.dart';
import 'package:illaj_app/res/components/round-button.dart';

class CarouselCardWidget extends StatelessWidget {
  const CarouselCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.greenColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'Looking For Your Desire\nSpecialist Doctor?',
              //   style: TextStyle(
              //       height: 1.2,
              //       fontSize: 15.sp,
              //       color: Colors.white,
              //       fontWeight: FontWeight.w600),
              // ),
              // 30.verticalSpace,
              SizedBox(
                child: Row(
                  children: [
                    Transform.scale(
                      scale: 0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'UPTO',
                            style: TextStyle(
                                height: 1.2,
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              Text(
                                '30%',
                                style: TextStyle(
                                    height: 1.2,
                                    fontSize: 30.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'OFFER*',
                                style: TextStyle(
                                    height: 1.2,
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          5.verticalSpace,
                          Text(
                            'On Health Products',
                            style: TextStyle(
                                height: 1.2,
                                fontSize: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          5.verticalSpace,
                          RoundButton(
                              buttonColor: AppColors.blaclColor,
                              height: 26.h,
                              width: 100.w,
                              title: 'Order Now',
                              onPressed: () {}),
                          5.verticalSpace,
                          Text(
                            'Super Medical Store',
                            style: TextStyle(
                                height: 1.2,
                                fontSize: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: Image.asset(
              ImageAssets.product,
              height: 70.h,
            ),
          )
        ],
      ),
    );
  }
}
