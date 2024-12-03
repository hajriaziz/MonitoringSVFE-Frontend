import 'dart:async';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:android_intent_plus/android_intent.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final StreamController<bool> _notificationStatusController =
      StreamController<bool>.broadcast();

  static Stream<bool> get notificationStatusStream =>
      _notificationStatusController.stream;

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'background_service_channel',
      'Service Notifications',
      description: 'Notifications pour les services en arrière-plan',
      importance: Importance.high,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'background_service_channel',
      'Service Notifications',
      channelDescription: 'Notifications pour les services en arrière-plan',
      importance: Importance.high,
      priority: Priority.high,
      ongoing: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);
    int uniqueId = Random().nextInt(100000);

    await _notificationsPlugin.show(
      uniqueId,
      title,
      body,
      platformDetails,
    );
  }

  static Future<bool> areNotificationsEnabled() async {
    return await Permission.notification.isGranted;
  }

  static Future<void> monitorNotificationPermissions() async {
    bool currentStatus = await areNotificationsEnabled();
    _notificationStatusController.add(currentStatus);

    Timer.periodic(Duration(seconds: 5), (timer) async {
      bool newStatus = await areNotificationsEnabled();
      if (newStatus != currentStatus) {
        currentStatus = newStatus;
        _notificationStatusController.add(currentStatus);
      }
    });
  }

  static Future<void> openNotificationSettings() async {
    final intent = AndroidIntent(
      action: 'android.settings.APP_NOTIFICATION_SETTINGS',
      arguments: <String, dynamic>{
        'android.provider.extra.APP_PACKAGE': 'com.example.smtmonitoring',
      },
    );
    await intent.launch();
  }

  static Future<void> requestNotificationPermission() async {
    await Permission.notification.request();
  }
}
