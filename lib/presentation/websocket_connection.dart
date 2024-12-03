import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smtmonitoring/presentation/notification_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  final _messageController = StreamController<String>.broadcast();
  final  ValueNotifier<bool> hasNotification = ValueNotifier<bool>(false); // <-- Notifie l'état des notifications


  bool _isConnected = false;
  bool notificationsEnabled = true;

  Stream<String> get messages => _messageController.stream;

  bool get isConnected => _isConnected;

  void connect(String url) {
    if (_isConnected) {
      print('WebSocket déjà connecté.');
      return;
    }

    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));
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
          reconnect(url);
        },
        onDone: () {
          print('Connexion WebSocket fermée.');
          _isConnected = false;
          reconnect(url);
        },
      );
    } catch (e) {
      print('Erreur lors de la connexion WebSocket : $e');
      _isConnected = false;
      reconnect(url);
    }
  }
    void resetNotificationState() {
    hasNotification.value = false; // Réinitialise l'état des notifications
  }

  void toggleNotifications(bool enabled, String url) {
    notificationsEnabled = enabled;

    if (enabled) {
      if (!_isConnected) {
        connect(url);
      }
    } else {
      disconnect();
    }
  }

  void reconnect(String url) {
    Future.delayed(Duration(seconds: 5), () {
      if (notificationsEnabled) {
        print('Tentative de reconnexion...');
        connect(url);
      }
    });
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
    _isConnected = false;
    print('WebSocket déconnecté.');
  }

  void listenToNotificationChanges(String url) {
    NotificationService.notificationStatusStream.listen((enabled) {
      toggleNotifications(enabled, url);
    });
  }
}
