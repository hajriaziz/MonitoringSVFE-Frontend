import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smtmonitoring/presentation/api_service.dart';
import '../models/transaction_par_jour_model.dart';

class Transaction_HistProvider extends ChangeNotifier {
  Transaction_HistModel? transactionModelObj;
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
  Future<void> fetchKPIs_hist(String token) async {
    isLoading = true;
    notifyListeners();

    try {
      Map<String, dynamic> kpiData = await ApiService().fetchKPIs_hist(token);
      print('KPI Data: $kpiData');
      transactionModelObj = Transaction_HistModel.fromJson(kpiData);
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
  List<TransactionTrendDataHist> _transactionTrendshist = [];

  // Getter to access the list of transaction trends
  List<TransactionTrendDataHist> get transactionTrendshist =>
      _transactionTrendshist;

  // Fetch Transaction Trends using the token
  Future<void> fetchTransactionTrends_hist(String token) async {
    isLoading = true;
    notifyListeners();

    try {
      List<dynamic> trendsData =
          await ApiService().fetchTransactionTrends_hist(token);
      print('Transaction Trends Data: $trendsData');

      // Convert the raw data into TransactionTrendData instances
      _transactionTrendshist = trendsData
          .map((data) => TransactionTrendDataHist.fromJson(data))
          .toList();

      // Optionally, print or use the mapped data
      for (var trend in _transactionTrendshist) {
        print(
            'Time: ${trend.timestamp}, Successful: ${trend.successfulTransactions}, Refused: ${trend.refusedTransactions}');
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
