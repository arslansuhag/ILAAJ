import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../mongoDatabase/apihelper.dart';
import '../../res/colors/app-colors.dart';
import '../../res/components/round-button.dart';

class adminorders extends StatefulWidget {
  const adminorders({super.key});

  @override
  State<adminorders> createState() => _adminordersState();
}

class _adminordersState extends State<adminorders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Orders"),
      ),
      body: FutureBuilder(
        future: ApiHelper.allorder(),
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
                                    5.verticalSpace,
                                    FutureBuilder(
                                      future: ApiHelper.getoneuser(
                                          snapshot.data[index]['uid']),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot3) {
                                        if (snapshot3.hasData) {
                                          log(snapshot3.data.toString());
                                          if (snapshot3.data.toString() ==
                                              "{}") {
                                            return const SizedBox.shrink();
                                          }
                                          return Row(
                                            children: [
                                              snapshot3.data['img'] != ""
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: Image.network(
                                                        snapshot3.data['img'],
                                                        fit: BoxFit.fill,
                                                        height: 50,
                                                        width: 50,
                                                      ))
                                                  : const Icon(
                                                      Icons.person,
                                                      size: 30,
                                                    ),
                                              10.horizontalSpace,
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot3.data['name'].toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.sp),
                                                  ),
                                                  Text(
                                                    snapshot3.data['phone'],
                                                    style: TextStyle(
                                                        fontSize: 11.sp),
                                                  ),
                                                  Text(
                                                    snapshot3.data['email'],
                                                    style: TextStyle(
                                                        fontSize: 11.sp),
                                                  ),
                                                  Text(
                                                    snapshot3.data['location'],
                                                    style: TextStyle(
                                                        fontSize: 10.sp),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        } else if (snapshot3.hasError) {
                                          return const Icon(
                                            Icons.error,
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                    10.verticalSpace,
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.amber.shade50,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "NAME : " +
                                                  snapshot2.data['title'],
                                              style: TextStyle(
                                                  height: 1.2,
                                                  fontSize: 15.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            3.verticalSpace,
                                            Text(
                                              "TYPE : " +
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
                                              "ACTUAL PRICE : " +
                                                  snapshot2.data['price'],
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
                                                "QUANTITY : ${snapshot.data[index]['quantity']}"),
                                            3.verticalSpace,
                                            Text(
                                              "TOTAL PRICE : ${int.parse(snapshot2.data['price']) * int.parse(snapshot.data[index]['quantity'])}",
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "STATUS : ",
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  style: TextStyle(
                                                      height: 1.2,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  snapshot.data[index]
                                                              ['status'] !=
                                                          'old'
                                                      ? "Recieved"
                                                      : "Delivered",
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  style: TextStyle(
                                                      height: 1.2,
                                                      fontSize: 12.sp,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            3.verticalSpace,
                                          ]),
                                    ),
                                    10.verticalSpace,
                                    snapshot.data[index]['status'] == 'new'
                                        ? RoundButton(
                                            buttonColor: AppColors.red,
                                            width: double.infinity,
                                            title: 'Done Order',
                                            onPressed: () async {
                                              await ApiHelper.updatestatus(
                                                  snapshot.data[index]['_id']);
                                              setState(() {});
                                            })
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ),
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
