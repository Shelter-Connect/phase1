import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'notifications_helper.dart';

class MessagingHelper {
  static final FirebaseMessaging _fcm = FirebaseMessaging();

  static void setup() {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      onMessage: _onMessage,
      onBackgroundMessage: _onMessage,
    );
  }

  static Future<String> getToken() {
    return _fcm.getToken();
  }

  static Future<void> _onMessage(Map<String, dynamic> message) async {
    Map<String, dynamic> data = message['data'];
    if (data['type'] == 'create') {
      return LocalNotificationsHelper.createNotification(
        title: data['title'],
        body: data['message'],
        id: int.parse(data['id']),
      );
    }
  }
}