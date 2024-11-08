import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000';

  // Save token to SharedPreferences
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  // Retrieve token from SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Clear token from SharedPreferences (optional: for logout)
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }

  // User login (JWT token generation) + Save token
  // login method inside ApiService
  Future<String> login(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/auth/signin/');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Ensure the access_token exists in the response
        if (data.containsKey('access_token')) {
          return data['access_token'];
        } else {
          throw Exception('Token not found in response');
        }
      } else {
        print("Login failed with status: ${response.statusCode}");
        print(response.body);
        throw Exception('Failed to login');
      }
    } catch (e) {
      print('Network error: $e');
      throw Exception('Network error');
    }
  }

  // Method to fetch transactions
  Future<List<dynamic>> fetchTransactions(String token) async {
    final url = Uri.parse('$baseUrl/transactions/');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // Pass the JWT token
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch transactions');
    }
  }

  // Fetch KPIs with automatically retrieved token
  Future<Map<String, dynamic>> fetchKPIs(String token) async {
    final url = Uri.parse('$baseUrl/kpis/');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to fetch KPIs. Status: ${response.statusCode}');
      throw Exception('Failed to fetch KPIs');
    }
  }
    // Fetch KPIs_hist with automatically retrieved token
  Future<Map<String, dynamic>> fetchKPIs_hist(String token) async {
    final url = Uri.parse('$baseUrl/kpis_hist/');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to fetch KPIs_hist. Status: ${response.statusCode}');
      throw Exception('Failed to fetch KPIs_hist');
    }
  }

  // Method to fetch terminal distribution
  Future<Map<String, dynamic>> fetchTerminalDistribution(String token) async {
    final url = Uri.parse('$baseUrl/terminal_distribution/');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // Pass the JWT token
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(
          'Failed to fetch terminal distribution. Status: ${response.statusCode}');
      throw Exception('Failed to fetch terminal distribution');
    }
  }

  // Method to fetch refusal rate per issuer
  Future<Map<String, dynamic>> fetchRefusalRatePerIssuer(String token) async {
    final url = Uri.parse('$baseUrl/refusal_rate_per_issuer/');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // Pass the JWT token
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to fetch refusal rate. Status: ${response.statusCode}');
      throw Exception('Failed to fetch refusal rate per issuer');
    }
  }

  // Method to check system status
  Future<Map<String, dynamic>> fetchSystemStatus(String token) async {
    final url = Uri.parse('$baseUrl/system_status/');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // Pass the JWT token
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to fetch system status. Status: ${response.statusCode}');
      throw Exception('Failed to fetch system status');
    }
  }
   // Method to fetch transaction trends
  Future<List<Map<String, dynamic>>> fetchTransactionTrends(String token) async {
    final url = Uri.parse('$baseUrl/transaction_trends/');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // Pass the JWT token
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      print('Failed to fetch transaction trends. Status: ${response.statusCode}');
      throw Exception('Failed to fetch transaction trends');
    }
  }
     // Method to fetch transaction trends hist
  Future<List<Map<String, dynamic>>> fetchTransactionTrends_hist(String token) async {
    final url = Uri.parse('$baseUrl/transaction_trends_hist/');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // Pass the JWT token
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      print('Failed to fetch transaction trends hist . Status: ${response.statusCode}');
      throw Exception('Failed to fetch transaction trends hist');
    }
  }
}

