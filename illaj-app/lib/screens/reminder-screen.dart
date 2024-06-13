import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/main.dart';
import 'package:illaj_app/mongoDatabase/apihelper.dart';

import '../res/colors/app-colors.dart';
import '../res/components/custom-text-field-widget.dart';
import '../res/components/round-button.dart';
import '../utils/app-utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;


class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Reminder',
          style: TextStyle(fontSize: 17.sp),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: ApiHelper.allremainderbyid(prefs.getString("id")!),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              if(snapshot.data.toString() == '[]'){
                return const Center(
                  child: Text("No Data"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(snapshot.data[index]['name'],style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
                          Text(snapshot.data[index]['date'],style: const TextStyle(fontWeight: FontWeight.bold),),
                          Text(snapshot.data[index]['time'],)
                        ],
                      ),
                    );
                  },
                );
              }
            } else if(snapshot.hasError){
              return const Icon(Icons.error,);
            } else{
              return const CircularProgressIndicator();
            }
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(context: context, builder: (BuildContext context) {
            return const Dialog(
              backgroundColor: Colors.white,
              child: addremainder()
            );
          });
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


class addremainder extends StatefulWidget {
  const addremainder({super.key});

  @override
  State<addremainder> createState() => _addremainderState();
}

class _addremainderState extends State<addremainder> {

  TextEditingController name = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.h),
          Text('Add Reminder', style: TextStyle(fontSize: 20.sp),),
          SizedBox(height: 10.h),
          CustomTextFieldWidget(
              controller: name, hintText: 'Name'),
          SizedBox(height: 10.h),
          RoundButton(
              buttonColor: AppColors.greenColor,
              width: 120.w,
              title: selectedDate == null ? 'Select Date' : selectedDate.toString().substring(0,10),
              onPressed: () async {
                _selectDate(context);
              }),
          SizedBox(height: 10.h),
          RoundButton(
              buttonColor: AppColors.greenColor,
              width: 120.w,
              title: selectedTime == null ? 'Select Time' : selectedTime!.format(context),
              onPressed: () async {
                _selectTime(context);
              }),
          SizedBox(height: 10.h),
          RoundButton(
              buttonColor: AppColors.greenColor,
              width: 120.w,
              title: 'Add',
              onPressed: () async {
                if ( name.text.isEmpty || selectedDate == null || selectedTime == null) {
                  AppUtils.snackBar('Reminder', 'All fields are required', const Duration(seconds: 2));
                } else {
                  initializeNotifications();
                  await ApiHelper.registerremainder(prefs.getString("id")!, name.text,
                      selectedDate.toString().substring(0,10), selectedTime!.format(context));
                  scheduleNotification(selectedDate!, selectedTime!);
                  Navigator.pop(context);
                  setState(() {});
                }
              })
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050, 12, 31),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }


  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(DateTime selectedDate, TimeOfDay selectedTime) async {
    final now = DateTime.now();
    var scheduledDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1)); // Schedule for tomorrow if in the past
    }
    final random = Random();
    final notificationId = random.nextInt(100000);
    final localTime = tz.TZDateTime.from(scheduledDate, tz.local);
    const AndroidNotificationDetails androidPlatformSpecifics =
    AndroidNotificationDetails('your_channel_id', 'Your Channel Name',
        channelDescription: 'Your channel description',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
        name.text,
        '',
        localTime,
        platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,);
  }

}
