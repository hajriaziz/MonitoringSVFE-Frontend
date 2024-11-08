import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smtmonitoring/presentation/api_service.dart';
import 'package:smtmonitoring/presentation/banque_screen/models/banque_model.dart';

class BanqueProvider extends ChangeNotifier {
  KPIsResponse? kpisData; // Modèle KPIs
  RefusalRatePerIssuer? refusalRateData; // Modèle Refus
  bool isLoading = false; // État de chargement
  String? errorMessage; // Gestion des erreurs

  /// Sauvegarde du token dans SharedPreferences
  Future<void> saveTokenToStorage(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
    print('Token saved successfully.');
  }

  /// Récupération du token depuis SharedPreferences
  Future<String?> getTokenFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  /// Fetch KPIs depuis l'API
  Future<void> fetchKPIs() async {
    isLoading = true;
    notifyListeners();

    try {
      final token = await getTokenFromStorage(); // Récupérer le token
      if (token == null) throw 'No token found. Please log in again.';

      // Appel de l'API via ApiService
      Map<String, dynamic> response = await ApiService().fetchKPIs(token);
      print('KPIs Data: $response');

      kpisData = KPIsResponse.fromJson(response); // Mapper la réponse
      errorMessage = null; // Réinitialiser les erreurs
    } catch (e) {
      print('Error fetching KPIs: $e');
      errorMessage = 'Failed to fetch KPIs: $e';
    } finally {
      isLoading = false;
      notifyListeners(); // Met à jour les widgets
    }
  }

  /// Fetch Refusal Rate par Issuer depuis l'API
  Future<void> fetchRefusalRatePerIssuer() async {
    isLoading = true;
    notifyListeners();

    try {
      final token = await getTokenFromStorage();
      if (token == null) throw 'No token found. Please log in again.';

      Map<String, dynamic> response =
          await ApiService().fetchRefusalRatePerIssuer(token);
      print('Refusal Rate Data: $response');

      refusalRateData = 
          RefusalRatePerIssuer.fromJson(response); // Mapper la réponse
      errorMessage = null;
    } catch (e) {
      print('Error fetching refusal rate: $e');
      errorMessage = 'Failed to fetch refusal rate: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Méthode pour tout récupérer en une fois
  Future<void> fetchAllData() async {
    isLoading = true;
    notifyListeners();

    try {
      await fetchKPIs();
      await fetchRefusalRatePerIssuer();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
