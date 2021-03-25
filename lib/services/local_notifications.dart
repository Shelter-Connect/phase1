import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsHelper {
  static final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  static void initialize() async {
    var androidSettings = AndroidInitializationSettings('mipmap/ic_launcher');
    var iosSettings = IOSInitializationSettings();
    var settings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await _localNotifications.initialize(settings);
  }

  static Future<void> scheduleNotification({DateTime time, String title, String body, int id}) async {
    var androidDetails = AndroidNotificationDetails(
      'cortex',
      'Task Reminders',
      'Reminds you of upcoming tasks.',
      importance: Importance.high,
    );
    var iosDetails = IOSNotificationDetails();
    var details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    if (time.isBefore(DateTime.now())) return;

    var scheduled =  await _localNotifications.pendingNotificationRequests();
    if (!scheduled.any((notification) => notification.id == id)) {
      await _localNotifications.schedule(
        id,
        title,
        body,
        time,
        details,
        androidAllowWhileIdle: true,
      );
    }
  }

  static Future<void> cancelNotification({int id}) async {
    await _localNotifications.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
  }
}