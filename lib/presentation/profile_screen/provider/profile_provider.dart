import '../models/profile_model.dart';
import 'package:flutter/material.dart';

/// A provider class for the PorfileScreen.
///
/// This provider manages the state of the PorfileScreen, including the
/// current porfileModelObj

// ignore_for_file: must_be_immutable
class PorfileProvider extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  ProfileModel porfileModelObj = ProfileModel();

  bool isSelectedSwitch = false;

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
  }

  void changeSwitchBox(bool value) {
    isSelectedSwitch = value;
    notifyListeners();
  }
}
