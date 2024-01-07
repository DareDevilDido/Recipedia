// import 'dart:html';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class notifi {

//   static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   static final on_Click = BehaviorSubject<String>();


//   //on tapping on notification
//   static void on_notifi_tap(NotificationResponse notificationResponse) {
//     on_Click.add(notificationResponse.payload!);
//   }

//   static Future init() async {
//     // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('app_icon');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//     DarwinInitializationSettings(
//         onDidReceiveLocalNotification: (id, title, body, payload) => null);
   
//     final InitializationSettings initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsDarwin);
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse:=>(Detail) ,
//         onDidReceiveBackgroundNotificationResponse: 
//     );
//   }
//   //simple noti
//   static Future SimpleNotification({
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//     AndroidNotificationDetails('your channel id', 'your channel name',
//         channelDescription: 'your channel description',
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker');
//     const NotificationDetails notificationDetails =
//     NotificationDetails(android: androidNotificationDetails);
//     await _flutterLocalNotificationsPlugin
//         .show(0, title, body, notificationDetails, payload: payload);
//   }

// //   static Future<void> scheduleDailyNotifications() async {
// //     final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// //     tz.initializeTimeZones();

// //     // Set your local timezone.
// //     // tz.setLocalLocation(tz.getLocation('Your_Timezone'));

// //     // Schedule for 8 AM, 12 PM, and 6 PM
// //     await _scheduleAtSpecificTime(flutterLocalNotificationsPlugin, 8, '8 AM Notification', 'This is your daily 8 AM notification!');
// //     await _scheduleAtSpecificTime(flutterLocalNotificationsPlugin, 6, '6 AM Notification', 'This is your daily 12 PM notification!');
// //     await _scheduleAtSpecificTime(flutterLocalNotificationsPlugin, 18, '6 PM Notification', 'This is your daily 6 PM notification!');
// //   }

// //   static Future<void> _scheduleAtSpecificTime(FlutterLocalNotificationsPlugin plugin, int hour, String title, String body) async {
// //     var now = tz.TZDateTime.now(tz.local);
// //     var scheduledTime = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour);
// //     if (now.isAfter(scheduledTime)) {
// //       scheduledTime = scheduledTime.add(const Duration(days: 1));
// //     }

// //     await plugin.zonedSchedule(
// //       hour, // Unique ID for each notification
// //       title,
// //       body,
// //       scheduledTime,
// //       const NotificationDetails(
// //         android: AndroidNotificationDetails(
// //           'your channel id',
// //           'Recepida',
// //           channelDescription: 'The Recepies of the day has changed',
// //         ),
// //       ),
// //       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
// //       matchDateTimeComponents: DateTimeComponents.time, // To repeat daily at the same time
// //     );
// //   }
//  }
