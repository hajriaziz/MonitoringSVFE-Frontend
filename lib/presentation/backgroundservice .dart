import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:smtmonitoring/presentation/notification_service.dart';
import 'package:smtmonitoring/presentation/websocket_connection.dart';

void initializeBackgroundService() {
  final service = FlutterBackgroundService();

  service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
      notificationChannelId: 'background_service_channel',
      initialNotificationTitle: 'Service actif',
      initialNotificationContent: 'Notifications en cours d\'exécution.',
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      autoStart: true,
    ),
  );
  service.startService();
}

void onStart(ServiceInstance service) async {
  final webSocketService = WebSocketService();

  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(
      title: 'SMT Monitoring',
      content: 'Service actif en arrière-plan',
    );
  }

  await NotificationService.monitorNotificationPermissions();

  webSocketService.listenToNotificationChanges();
  webSocketService.connect();

webSocketService.messages.listen((message) async {
  await NotificationService.showNotification(
    'Notification', // Titre de la notification
    message, // Corps de la notification (texte court)
    bigText: message, // Texte complet pour BigTextStyle
  );
});

  service.on('stopService').listen((event) {
    webSocketService.disconnect();
    service.stopSelf();
  });
}
