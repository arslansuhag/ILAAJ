import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:illaj_app/main.dart';
import 'package:illaj_app/mongoDatabase/apihelper.dart';

import '../res/colors/app-colors.dart';
import '../res/components/round-button.dart';

class patorders extends StatefulWidget {
  const patorders({super.key});

  @override
  State<patorders> createState() => _patordersState();
}

class _patordersState extends State<patorders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
      ),
      body: FutureBuilder(
        future: ApiHelper.allorderbypat(prefs.getString("id")!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.toString() == '[]') {
              return const Center(
                child: Text("No Data"),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: ApiHelper.marketone(snapshot.data[index]['mid']),
                    builder: (BuildContext context, AsyncSnapshot snapshot2) {
                      if (snapshot2.hasData) {
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(10.h),
                          constraints:
                              const BoxConstraints(maxHeight: double.infinity),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 3),
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 4),
                              ],
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12.r)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 110.h,
                                  width: double.infinity.w,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot2.data['img']),
                                          fit: BoxFit.cover),
                                      color: AppColors.white,
                                      borderRadius:
                                          BorderRadius.circular(12.r))),
                              Padding(
                                padding: EdgeInsets.all(10.h),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot2.data['title'],
                                      style: TextStyle(
                                          height: 1.2,
                                          fontSize: 15.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    3.verticalSpace,
                                    Text(
                                      snapshot2.data['type'],
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          height: 1.2,
                                          fontSize: 12.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    3.verticalSpace,
                                    Text(
                                      "Total Price : ${int.parse(snapshot2.data['price']) * int.parse(snapshot.data[index]['quantity'])}",
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          height: 1.2,
                                          fontSize: 12.sp,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    3.verticalSpace,
                                    Text(
                                      snapshot.data[index]['status'] != 'old'
                                          ? "Recieved"
                                          : "Delivered",
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          height: 1.2,
                                          fontSize: 12.sp,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    10.verticalSpace,
                                    snapshot.data[index]['status'] == 'new'
                                        ? RoundButton(
                                            buttonColor: AppColors.red,
                                            width: 120.w,
                                            title: 'Cancel Order',
                                            onPressed: () async {
                                              await ApiHelper.cancleorder(
                                                  snapshot.data[index]['_id']);
                                              setState(() {});
                                            })
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      } else if (snapshot2.hasError) {
                        return const Icon(
                          Icons.error,
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  );
                },
              );
            }
          } else if (snapshot.hasError) {
            return const Icon(
              Icons.error,
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
