import 'package:flutter/material.dart';
import '../models/barnav_container_model.dart';

/// A provider class for the BarnavContainerScreen.
///
/// This provider manages the state of the BarnavContainerScreen, including the
/// current barnavContainerModelObj

// ignore_for_file: must_be_immutable
class BarnavContainerProvider extends ChangeNotifier {
  BarnavContainerModel barnavContainerModelObj = BarnavContainerModel();
  @override
  void dispose() {
    super.dispose();
  }
}
