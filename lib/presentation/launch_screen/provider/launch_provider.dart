import 'package:flutter/material.dart';
//import '../../../core/app_export.dart';
import '../models/launch_model.dart';

/// A provider class for the LaunchScreen.
///
/// This provider manages the state of the LaunchScreen, including the
/// current launchModelObj
// ignore_for_file: must_be_immutable
class LaunchProvider extends ChangeNotifier {
  LaunchModel launchModelObj = LaunchModel();
  @override
  void dispose() {
    super.dispose();
  }
}
