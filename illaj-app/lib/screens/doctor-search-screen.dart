import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/res/components/doctor-search-card.dart';
import 'package:illaj_app/res/components/reuseable-widget.dart';

class DoctorSearchScreen extends StatefulWidget {
  const DoctorSearchScreen({super.key});

  @override
  State<DoctorSearchScreen> createState() => _DoctorSearchScreenState();
}

class _DoctorSearchScreenState extends State<DoctorSearchScreen> {
  final List<String> doctorsList = [
    'Dr. Serena Gome',
    'Dr. Asma Khan',
    'Dr. Kiran Shakia',
    'Dr. Nima Khan',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc5d9fa),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Selected area',
              style: TextStyle(fontSize: 12.sp, color: Colors.black54),
            ),
            Text(
              'Boston',
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ReUseAbleWidget(
              leftText: 'All Cardiologist', rightText: 'See All'),
          10.verticalSpace,
          ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              primary: true,
              itemBuilder: (context, index) {
                return DoctorSearchCard(
                  title: doctorsList[index],
                );
              })
        ],
      ),
    );
  }
}
