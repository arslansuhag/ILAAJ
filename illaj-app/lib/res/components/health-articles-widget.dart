// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illaj_app/mongoDatabase/apihelper.dart';
import 'package:illaj_app/res/colors/app-colors.dart';

class HealthArticleCard extends StatelessWidget {
  String title;
  String description;
  String image;
  String uid;
  HealthArticleCard(
      {super.key,
      required this.title,
      required this.description,
      required this.uid,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: ApiHelper.getoneuser(uid),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: snapshot.data["imageUrl"].toString() == "null"
                                  ? const Icon(
                                      Icons.person,
                                      size: 50,
                                    )
                                  : Image.network(
                                      snapshot.data["img"],
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )),
                          10.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data['name'].toString(),
                                  style: TextStyle(
                                      height: 1.2,
                                      fontSize: 15.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  snapshot.data['description'].toString(),
                                  style: TextStyle(
                                    height: 1.2,
                                    fontSize: 10.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Icon(
                        Icons.error,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                10.verticalSpace,
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
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      height: 1.2,
                      fontSize: 10.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
