import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smtmonitoring/presentation/api_service.dart';
import '../models/notification_model.dart';


class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notifications = [];
  bool isLoading = false;
  String? errorMessage;

  // Getter pour accéder aux notifications
  List<NotificationModel> get notifications => _notifications;

  // Save the token to storage (SharedPreferences)
  Future<void> saveTokenToStorage(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
    print('Token saved successfully.');
  }

  // Retrieve the token from storage (SharedPreferences)
  Future<String?> getTokenFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }
  // Fonction pour récupérer les notifications depuis l'API
  Future<void> fetchNotifications({int limit = 10}) async {
    isLoading = true;
    notifyListeners();

    try {
      final token = await getTokenFromStorage();
      if (token == null) {
        throw Exception('Token not found. Please log in again.');
      }

      List<dynamic> alertsData = await ApiService().fetchAlerts(token, limit: limit);

      // Convertir les données JSON en une liste d'objets NotificationModel
      _notifications = alertsData
          .map((data) => NotificationModel.fromJson(data))
          .toList();

      errorMessage = null; // Réinitialiser les erreurs en cas de succès
    } catch (e) {
      print('Error fetching notifications: $e');
      errorMessage = 'Failed to fetch notifications: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  void removeNotification(int index) {
  _notifications.removeAt(index);
  notifyListeners(); // Appeler notifyListeners à l'intérieur du provider
}
}
