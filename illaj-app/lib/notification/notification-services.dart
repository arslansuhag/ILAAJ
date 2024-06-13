// ignore_for_file: deprecated_member_use

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:illaj_app/models/appointments.dart';

// class NotificationServices {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   initializeNotifications() {
//     // Initialize the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     var initializationSettingsAndroid =
//         const AndroidInitializationSettings('app_icon');
//     var initializationSettingsIOS = const DarwinInitializationSettings();
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future showNotification(Appointment appointment) async {
//     var scheduledNotificationDateTime =
//         DateTime.parse('${appointment.date} ${appointment.time}');
//     var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//         'your channel id', 'your channel name',
//         importance: Importance.max, priority: Priority.high, showWhen: false);
//     var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.schedule(
//         0,
//         'Appointment Reminder',
//         'You have an appointment with ${appointment.doctorName} at ${appointment.time}',
//         scheduledNotificationDateTime,
//         platformChannelSpecifics);
//   }
// }

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:illaj_app/models/appointments.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotifications() {
    // Initialize the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    tz.initializeTimeZones(); // Initialize time zones for zoned scheduling
  }

  Future showNotification(Appointment appointment) async {
    tz.TZDateTime scheduledNotificationDateTime = tz.TZDateTime.parse(
        tz.local, '${appointment.date} ${appointment.time}');
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high, showWhen: false);
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Appointment Reminder',
        'You have an appointment with ${appointment.doctorName} at ${appointment.time}',
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        androidAllowWhileIdle:
            true, // Add this line if you want to allow the notification to be shown even when the phone is in idle/doze mode.
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
