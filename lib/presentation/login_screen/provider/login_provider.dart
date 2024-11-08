import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smtmonitoring/core/utils/navigator_service.dart';
import 'package:smtmonitoring/presentation/api_service.dart';
import 'package:smtmonitoring/presentation/login_screen/models/login_model.dart';
import 'package:smtmonitoring/routes/app_routes.dart';

/// A provider class for the LoginScreen.
/// This provider manages the state of the LoginScreen, including the current loginModelObj.
class LoginProvider extends ChangeNotifier {
  // Controllers for email and password input
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // LoginModel instance to hold the login state
  LoginModel loginModelObj = LoginModel();

  // Variable to manage password visibility
  bool isShowPassword = true;

  // Variable to store error messages
  String? errorMessage;

  @override
  void dispose() {
    // Dispose controllers to free up resources
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Toggles the visibility of the password.
  void changePasswordVisibility() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

  /// Saves the token to SharedPreferences.
  Future<void> saveTokenToStorage(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
    print('Token saved successfully.');
  }

  /// Method to handle user sign-in.
  /// Returns true if sign-in is successful, otherwise returns false.
  Future<bool> signIn(BuildContext context) async {
    String email = emailController.text; // Capture the email input
    String password = passwordController.text; // Capture the password input

    try {
      // Attempt to log in and get the token
      String token = await ApiService().login(email, password);
      loginModelObj.token = token; // Save the token in the LoginModel

      // Save the token to storage for future use
      await saveTokenToStorage(token);

      // Navigate to the next screen on success
      NavigatorService.pushNamed(AppRoutes.barnavContainerScreen);
      return true;
    } catch (e) {
      // Capture any error that occurs during sign-in
      errorMessage = 'Failed to log in. Please check your credentials.';
      print('Login error: $e');
      notifyListeners(); // Update UI with error message
      return false;
    }
  }
}
