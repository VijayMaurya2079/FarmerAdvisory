import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    _initializeLocalNotifications();
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _initializeLocalNotifications() {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('launcher_icon');
    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    _localNotifications.initialize(initializationSettings);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();
    if (kDebugMode) {
      print('Token: $fCMToken');
    }

    FirebaseMessaging.onBackgroundMessage(handleFirebaseMessage);
    FirebaseMessaging.onMessage.listen(handleFirebaseMessage);
  }

  Future<void> handleFirebaseMessage(RemoteMessage message) async {
    var notification = message.notification;
    if (notification == null) return;
    const androidChannel = AndroidNotificationDetails(
      'high_importance_channel',
      'Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const notificationDetails = NotificationDetails(android: androidChannel);

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      notificationDetails,
      payload: "",
    );
  }
}
