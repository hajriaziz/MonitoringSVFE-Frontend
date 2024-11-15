import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smtmonitoring/presentation/api_service.dart';
import 'package:smtmonitoring/presentation/terminal_screen/models/terminal_model.dart';

class TerminalProvider extends ChangeNotifier {
  TerminalDistributionModel? terminalDistribution; // Model object
  bool isLoading = false;
  String? errorMessage;

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

// Fetch terminal distribution using the token
  Future<void> fetchTerminalDistribution() async {
    isLoading = true;
    notifyListeners();

    try {
      final token = await getTokenFromStorage(); // Retrieve the token
      if (token == null) throw 'No token found. Please log in again.';

      Map<String, dynamic> response =
          await ApiService().fetchTerminalDistribution(token);
      print('Terminal Distribution Data: $response');

      // Pass the entire response to TerminalDistributionModel
      terminalDistribution = TerminalDistributionModel.fromJson(response);
      errorMessage = null; // Clear any previous errors
    } catch (e) {
      print('Error fetching terminal distribution: $e');
      errorMessage = 'Failed to fetch data: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
