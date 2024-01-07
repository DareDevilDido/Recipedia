
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class DailyNotificationManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  DailyNotificationManager() {
    tz.initializeTimeZones();
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleDailyNotifications() async {
    var androidDetails = AndroidNotificationDetails(
      'daily_notification_channel_id',
      'Daily Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformDetails = NotificationDetails(android: androidDetails);

    List<TimeOfDay> notificationTimes = [
      TimeOfDay(hour:2,minute: 45), // 12 PM
      TimeOfDay(hour:18,minute: 0), // 6 PM
      TimeOfDay(hour:0,minute: 0), // 12 AM
    ];

    for (int i = 0; i < notificationTimes.length; i++) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        i, // Unique ID for each notification
        'Notification ${i + 1}',
        'The recipe of the day has been changed ${i + 1}',
        _nextInstanceOfTime(notificationTimes[i]),
        platformDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour, time.minute);
    return scheduledDate.isBefore(now) ? scheduledDate.add(Duration(days: 1)) : scheduledDate;
  }
}
