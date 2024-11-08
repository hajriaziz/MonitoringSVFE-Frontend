import 'package:flutter/material.dart';
import '../models/barnav_model.dart';

/// A provider class for the BarnavPage.
///
/// This provider manages the state of the BarnavPage, including the
/// current barnavModelObj

// ignore_for_file: must_be_immutable
class BarnavProvider extends ChangeNotifier {
  BarnavModel barnavModelObj = BarnavModel();
  @override
  void dispose() {
    super.dispose();
  }
}
