import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smtmonitoring/presentation/notification_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  final _messageController = StreamController<String>.broadcast();
  final ValueNotifier<bool> hasNotification =
      ValueNotifier<bool>(false); // <-- Notifie l'état des notifications

  bool _isConnected = false;
  bool notificationsEnabled = true;

  Stream<String> get messages => _messageController.stream;

  bool get isConnected => _isConnected;
  // Default WebSocket URL
  //final String _url = 'ws://192.168.1.188:8000/ws/notifications';
  //final String _url = 'ws://10.0.2.2:8000/ws/notifications';
  final String _url = 'wss://smtmonitoring.clictopay.com/ws/notifications';

  void connect() {
    if (_isConnected) {
      print('WebSocket déjà connecté.');
      return;
    }

    try {
      _channel = WebSocketChannel.connect(Uri.parse(_url));
      _isConnected = true;

      _channel!.stream.listen(
        (message) {
          if (notificationsEnabled) {
            print('Message reçu : $message');
            _messageController.add(message);

            // Change l'état des notifications à "true"
            hasNotification.value = true;
          }
        },
        onError: (error) {
          print('Erreur WebSocket : $error');
          _isConnected = false;
          reconnect();
        },
        onDone: () {
          print('Connexion WebSocket fermée.');
          _isConnected = false;
          reconnect();
        },
      );
    } catch (e) {
      print('Erreur lors de la connexion WebSocket : $e');
      _isConnected = false;
      reconnect();
    }
  }

  void resetNotificationState() {
    hasNotification.value = false; // Réinitialise l'état des notifications
  }

  void toggleNotifications(bool enabled) {
    notificationsEnabled = enabled;

    if (enabled) {
      if (!_isConnected) {
        connect();
      }
    } else {
      disconnect();
    }
  }

  void reconnect() {
    Future.delayed(Duration(seconds: 5), () {
      if (notificationsEnabled) {
        print('Tentative de reconnexion...');
        connect();
      }
    });
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
    _isConnected = false;
    print('WebSocket déconnecté.');
  }

  void listenToNotificationChanges() {
    NotificationService.notificationStatusStream.listen((enabled) {
      toggleNotifications(enabled);
    });
  }
}
