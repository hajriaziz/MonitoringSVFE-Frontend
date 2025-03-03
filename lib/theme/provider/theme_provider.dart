﻿//import 'package: flutter/material.dart';
//import '../../core/app_export.dart';

import 'package:flutter/material.dart';
import 'package:smtmonitoring/core/utils/pref_utils.dart';

class ThemeProvider extends ChangeNotifier {
  themeChange(String themeType) async {
    PrefUtils().setThemeData(themeType);
    notifyListeners();
  }
}
