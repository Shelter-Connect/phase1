import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationsHelper {
  static final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  static void initialize() async {
    var androidSettings = AndroidInitializationSettings('mipmap/ic_launcher');
    var iosSettings = IOSInitializationSettings();
    var settings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await _localNotifications.initialize(settings);
  }

  static Future<void> createNotification({int id, String title, String body}) async {
    var androidDetails = AndroidNotificationDetails(
      'linkare',
      'linkare',
      'linkare',
      importance: Importance.high,
    );
    var iosDetails = IOSNotificationDetails();
    var details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    _localNotifications.show(
      id,
      title,
      body,
      details,
    );
  }

  static Future<void> scheduleNotification({DateTime time, String title, String body, int id}) async {
    var androidDetails = AndroidNotificationDetails('cortex', 'cortex', 'cortex');
    var iosDetails = IOSNotificationDetails();
    var details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    if (time.isBefore(DateTime.now())) return;

    var scheduled =  await _localNotifications.pendingNotificationRequests();
    if (!scheduled.any((notification) => notification.id == id)) {
      await _localNotifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(time, tz.local),
        details,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}