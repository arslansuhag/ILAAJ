// ignore_for_file: unnecessary_null_comparison, must_be_immutable, prefer_typing_uninitialized_variables, deprecated_member_use
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/controllers/appointment-controller.dart';
import 'package:illaj_app/models/appointments.dart';
import 'package:illaj_app/mongoDatabase/mongodb.dart';
import 'package:illaj_app/notification/notification-services.dart';
import 'package:illaj_app/res/colors/app-colors.dart';
import 'package:illaj_app/res/components/round-button.dart';
import 'package:illaj_app/screens/bottom-navBar-screen.dart';
import 'package:illaj_app/utils/app-utils.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mongoDatabase/apihelper.dart';

class BookAppointmentScreen extends StatefulWidget {
  var doctorId;
  var doctorName;
  BookAppointmentScreen(
      {super.key, required this.doctorId, required this.doctorName});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final AppointmentController appointmentController =
      Get.put(AppointmentController());
  final MongoDataBase mongoDataBase = MongoDataBase();
  final unSelected = Colors.white;
  final activeColor = AppColors.greenColor;
  late DateTime _dateTime;
  late String formattedDate;
  Timer? timer;
  final NotificationServices notificationService = NotificationServices();

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(_dateTime);
    notificationService.initializeNotifications();
    scheduleAppointments();
    timer = Timer.periodic(
        const Duration(hours: 2), (Timer t) => scheduleAppointments());
  }

  void scheduleAppointments() async {
    String patientId = await getPatientId();
    List<Appointment> appointments = await fetchAppointments(patientId);

    for (var appointment in appointments) {
      notificationService.showNotification(appointment);
    }
  }

  Future<String> getPatientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Assuming 'patientId' is stored under the key 'patient_id'
    String patientId = prefs.getString('id') ?? '';
    return patientId;
  }

  Future<List<Appointment>> fetchAppointments(String patientId) async {
    var appointments =
        await ApiHelper.getbypatient(patientId);
    return appointments.map((doc) => Appointment.fromMap(doc)).toList();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Future<void> scheduleNotification() async {
  //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //       FlutterLocalNotificationsPlugin();

  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'your_channel_id',
  //     'your_channel_name',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );

  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);

  //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  //   tz.TZDateTime scheduledDate = tz.TZDateTime(
  //     tz.local,
  //     _dateTime.year,
  //     _dateTime.month,
  //     _dateTime.day,
  //     _dateTime.hour,
  //     _dateTime.minute,
  //   );

  //   // Check if scheduled date is in the future
  //   if (scheduledDate.isBefore(now)) {
  //     print("Scheduled date is in the past. Not scheduling notification.");
  //     return;
  //   }

  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     0,
  //     'Appointment Reminder',
  //     'Your appointment is scheduled for ${time[appointmentController.selectedIndex.value]} on $formattedDate',
  //     scheduledDate,
  //     platformChannelSpecifics,
  //     androidAllowWhileIdle: true,
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //     matchDateTimeComponents: DateTimeComponents.time,
  //   );
  // }

  void _showDatePicker(BuildContext context) async {
    DateTime? value = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (value != null) {
      setState(() {
        _dateTime = value;
        formattedDate = DateFormat('yyyy-MM-dd').format(_dateTime);
      });
    }
  }

  final List<String> time = [
    '08:00 AM',
    '09:15 AM',
    '11:30 AM',
    '01:40 PM',
    '3:10 PM',
    '4:30 PM',
  ];

// ******** Function for Book Appointment for a doctor ******** //
  Future<void> bookAppointment() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('id');
      String? patientName = prefs.getString('name');

      if (appointmentController.selectedIndex >= 0 &&
          appointmentController.selectedIndex < time.length) {

        bool s = await ApiHelper.registerappointment(widget.doctorId, widget.doctorName,
            time[appointmentController.selectedIndex.value], formattedDate, userId!, patientName!);
        if (s){
          AppUtils.snackBar('Appointment', 'Appointment Booked Successfully',
              const Duration(seconds: 2));
          Get.off(() => const BottomNavBarScreen());
        } else {
          AppUtils.snackBar('Appointment', 'Try again later',
              const Duration(seconds: 2));
        }
      } else {
        print("Invalid selectedIndex: ${appointmentController.selectedIndex.value}");
      }
    } catch (e) {
      print("Error booking appointment to MongoDB: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          'Appointment',
          style: TextStyle(fontSize: 17.sp),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Text(
              'Slots',
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
            ),
            10.verticalSpace,
            GridView.builder(
              shrinkWrap: true,
              primary: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: time.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      appointmentController.setColor(index);
                    },
                    child: Obx(
                      () => Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:
                                  appointmentController.selectedIndex.value ==
                                          index
                                      ? activeColor
                                      : unSelected,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Text(
                            time[index],
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  appointmentController.selectedIndex.value ==
                                          index
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          )),
                    ));
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 3,
                  childAspectRatio: 3.0),
            ),
            30.verticalSpace,
            RoundButton(
                buttonColor: AppColors.greenColor,
                width: double.infinity,
                title: 'Confirm Appointment',
                onPressed: () {
                  bookAppointment();
                })
          ],
        ),
      ),
    );
  }
}
