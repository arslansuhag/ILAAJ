import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illaj_app/mongoDatabase/apihelper.dart';

class ReceivedAppointmentCard extends StatelessWidget {
  String name;
  String time;
  String date;
  String status;
  String id;
  final Function() onCancel;
  final Function() onupdate;
  ReceivedAppointmentCard(
      {super.key,
      required this.date,
      required this.name,
      required this.time,
      required this.status,
      required this.id,
      required this.onCancel,
      required this.onupdate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      // ignore: prefer_const_constructors
      padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 10.h),
      // height: 100.h,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 3),
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 4),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    13.verticalSpace,
                    Text(
                      'Date',
                      style: TextStyle(
                          height: 1.2,
                          fontSize: 10.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                          height: 1.2,
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    13.verticalSpace,
                    Text(
                      'Time',
                      style: TextStyle(
                          height: 1.2,
                          fontSize: 10.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                          height: 1.2,
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    13.verticalSpace,
                    Text(
                      'Patient Name',
                      style: TextStyle(
                          height: 1.2,
                          fontSize: 10.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          height: 1.2,
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          10.verticalSpace,
          Row(
            children: [
              Text(
                'Status',
                style: TextStyle(
                    height: 1.2,
                    fontSize: 10.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              ),
              10.horizontalSpace,
              Text(
                status == "new"
                    ? "Pending"
                    : status == "old"
                        ? "Done"
                        : status,
                style: TextStyle(
                    height: 1.2,
                    fontSize: 12.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          5.verticalSpace,
          FutureBuilder(
            future: ApiHelper.getoneuser(id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                              height: 1.2,
                              fontSize: 10.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                        10.horizontalSpace,
                        Text(
                          snapshot.data["name"].toString(),
                          style: TextStyle(
                              height: 1.2,
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Number',
                          style: TextStyle(
                              height: 1.2,
                              fontSize: 10.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                        10.horizontalSpace,
                        Text(
                          snapshot.data["phone"].toString(),
                          style: TextStyle(
                              height: 1.2,
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Location',
                          style: TextStyle(
                              height: 1.2,
                              fontSize: 10.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                        10.horizontalSpace,
                        Text(
                          snapshot.data["location"].toString(),
                          style: TextStyle(
                              height: 1.2,
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return const Icon(Icons.error);
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          20.verticalSpace,
          status == 'new'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: onCancel, child: const Text('Cancel'))),
                    10.horizontalSpace,
                    Expanded(
                        child: ElevatedButton(
                            onPressed: onupdate, child: const Text('Done'))),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
