import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smtmonitoring/presentation/api_service.dart';
import 'package:smtmonitoring/presentation/transaction_screen/models/transaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  TransactionModel? transactionModelObj;
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

  // Fetch KPIs using the token
  Future<void> fetchKPIs(String token) async {
    isLoading = true;
    notifyListeners();

    try {
      Map<String, dynamic> kpiData = await ApiService().fetchKPIs(token);
      print('KPI Data: $kpiData');
      transactionModelObj = TransactionModel.fromJson(kpiData);
      errorMessage = null; // Clear any previous errors
    } catch (e) {
      print('Error fetching KPIs: $e');
      errorMessage = 'Failed to fetch KPIs: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

 // Add this private list to hold the transaction trends data
  List<TransactionTrendData> _transactionTrends = [];

  // Getter to access the list of transaction trends
  List<TransactionTrendData> get transactionTrends => _transactionTrends;

  // Fetch Transaction Trends using the token
  Future<void> fetchTransactionTrends(String token) async {
    isLoading = true;
    notifyListeners();

    try {
      List<dynamic> trendsData = await ApiService().fetchTransactionTrends(token);
      print('Transaction Trends Data: $trendsData');

      // Convert the raw data into TransactionTrendData instances
      _transactionTrends = trendsData
          .map((data) => TransactionTrendData.fromJson(data))
          .toList();

      // Optionally, print or use the mapped data
      for (var trend in _transactionTrends) {
        print('Time: ${trend.timestamp}, Successful: ${trend.successfulTransactions}, Refused: ${trend.refusedTransactions}');
      }

      errorMessage = null; // Clear any previous errors
    } catch (e) {
      print('Error fetching Transaction Trends: $e');
      errorMessage = 'Failed to fetch Transaction Trends: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
