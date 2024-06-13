// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/res/components/round-button.dart';
import 'package:illaj_app/screens/bottom-navBar-screen.dart';
import 'package:illaj_app/screens/doctor-search-screen.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController searchController = Get.put(SearchController());
  DateTime _dateTime = DateTime.now();
  void _showDatePicker(BuildContext context) async {
    DateTime? value = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (value != null) {
      setState(() {
        _dateTime = value;
      });
    }
  }

  String selectedArea = 'Select an Area';
  List<String> areas = [
    'Select an Area',
    'Area A',
    'Area B',
    'Area C',
    'Area D'
  ];

  String selectSpecialization = 'Doctor, Specialist';
  List<String> doctors = [
    'Doctor, Specialist',
    'Cardiology',
    'Dermatology',
    'Emergency Medicine.',
    'General Surgery'
  ];
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.off(() => const BottomNavBarScreen());
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          'Search Here',
          style: TextStyle(fontSize: 17.sp),
        ),
      ),
      backgroundColor: const Color(0xffc5d9fa),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search Your',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
            Text(
              'Specialist',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
            10.verticalSpace,
            Container(
              padding: EdgeInsets.all(8.h),
              height: 45.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 3),
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 4),
                  ]),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedArea,
                underline: Container(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedArea = newValue!;
                  });
                },
                items: areas.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 13.sp, color: Colors.black54),
                    ),
                  );
                }).toList(),
              ),
            ),
            10.verticalSpace,
            Container(
              padding: EdgeInsets.all(8.h),
              height: 45.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 3),
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 4),
                  ]),
              child: DropdownButton<String>(
                isExpanded: true,
                underline: Container(),
                value: selectSpecialization,
                onChanged: (String? newValue) {
                  setState(() {
                    selectSpecialization = newValue!;
                  });
                },
                items: doctors.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 13.sp, color: Colors.black54),
                    ),
                  );
                }).toList(),
              ),
            ),
            10.verticalSpace,
            GestureDetector(
              onTap: () {
                _showDatePicker(context);
              },
              child: Container(
                padding: EdgeInsets.all(8.h),
                height: 45.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 3),
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 4),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _dateTime != null
                          ? DateFormat('yyyy-MM-dd').format(_dateTime)
                          : 'Select Date',
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500),
                    ),
                    const Icon(Icons.calendar_month_rounded)
                  ],
                ),
              ),
            ),
            20.verticalSpace,
            RoundButton(
                buttonColor: const Color(0xff2060c9),
                width: double.infinity,
                title: 'Search',
                onPressed: () {
                  Get.to(() => DoctorSearchScreen());
                })
          ],
        ),
      ),
    );
  }
}
