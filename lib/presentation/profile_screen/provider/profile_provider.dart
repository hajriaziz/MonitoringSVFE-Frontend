import 'dart:convert';
import 'dart:io';
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

  // For storing image path and file
  String? _imagePath;
  File? _imageFile;

  String? get imagePath => _imagePath;
  File? get imageFile => _imageFile;

  ProfileProvider({required this.apiService});
  Uint8List? _base64Image;
  Uint8List? get base64Image => _base64Image;

  void setBase64Image(String? base64String) {
    if (base64String != null && base64String.isNotEmpty) {
      _base64Image = base64Decode(base64String);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  // Method to set the image file
  void setImageFile(File? imageFile) {
    _imageFile = imageFile;
    notifyListeners();
    // Save to SharedPreferences
  }

  // Method to set image URL from backend
  void setImageUrl(String? url) {
    _imagePath = url;
    notifyListeners();
  }

  // Retrieve the token from SharedPreferences
  Future<String?> getTokenFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  // Fetch user profile details
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

      // Update controllers with data
      userNameController.text = profileModel?.username ?? '';
      phoneController.text = profileModel?.phone ?? '';
      emailController.text = profileModel?.email ?? '';

      // Handle image source
      final imagePath = profileModel?.imagePath;
      if (imagePath != null && imagePath.startsWith('data:image')) {
        // Handle base64-encoded images
        setBase64Image(imagePath.split(',').last);
      } else {
        setBase64Image(null);
      }

      errorMessage = null;
    } catch (e) {
      errorMessage = 'Failed to fetch user profile: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Update user profile details
  Future<void> updateUserProfile() async {
    try {
      isLoading = true;
      notifyListeners();

      final token = await getTokenFromStorage();
      if (token == null) {
        throw Exception('Token not found. Please login again.');
      }

      String? imageFilePath;
      if (_imageFile != null) {
        imageFilePath = _imageFile!.path;
      }

      await apiService.updateUserDetails(
        username: userNameController.text,
        phone: phoneController.text,
        imageFilePath: imageFilePath,
        token: token,
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
