import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smtmonitoring/presentation/api_service.dart';
import '../models/profile_model.dart';

class ProfileProvider extends ChangeNotifier {
  final ApiService apiService;
  ProfileModel? profileModel;

  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;
  bool isSelectedSwitch = false;

  ProfileProvider({required this.apiService});

  @override
  void dispose() {
    userNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Uint8List? _imageBytes;  // Field to store the image bytes

  // Getter to access the imageBytes
  Uint8List? get imageBytes => _imageBytes;

  // Method to update the imageBytes
  void setImageBytes(Uint8List? imageBytes) {
    _imageBytes = imageBytes;
    notifyListeners();
  }

  // Retrieve the token from SharedPreferences
  Future<String?> getTokenFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  // Fetch user profile details
  Future<void> fetchUserProfile() async {
    try {
      isLoading = true;
      notifyListeners();

      final token = await getTokenFromStorage();
      if (token == null) {
        throw Exception('Token not found. Please login again.');
      }

      final response = await apiService.getUserProfile(token);
      profileModel = ProfileModel.fromJson(response);

      // Update the controllers with the fetched data
      userNameController.text = profileModel?.username ?? '';
      phoneController.text = profileModel?.phone ?? '';
      emailController.text = profileModel?.email ?? '';

      errorMessage = null;
    } catch (e) {
      errorMessage = 'Failed to fetch user profile: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Update user profile details
  Future<void> updateUserProfile(Uint8List? imageBytes) async {
    try {
      isLoading = true;
      notifyListeners();

      final token = await getTokenFromStorage();
      if (token == null) {
        throw Exception('Token not found. Please login again.');
      }

      await apiService.updateUserDetails(
        username: userNameController.text,
        phone: int.tryParse(phoneController.text),
        imageBytes: imageBytes?.toList(), token: token,
      );

      // Refresh the profile after update
      await fetchUserProfile();
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Failed to update user profile: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Change the state of the notification switch
  void changeSwitchBox(bool value) {
    isSelectedSwitch = value;
    notifyListeners();
  }
}
