import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style

  static ButtonStyle get fillPrimary => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.h),
        ),
        elevation: 0,
      );
  static ButtonStyle get fillBleu => ElevatedButton.styleFrom(
        backgroundColor: appTheme.blue200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.h),
        ),
        elevation: 0,
      );
  static ButtonStyle get fillLightBleu => ElevatedButton.styleFrom(
        backgroundColor: appTheme.lightBlue700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.h),
        ),
        elevation: 0,
      );
  // text button style
  static ButtonStyle get none => ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      elevation: MaterialStateProperty.all<double>(0),
      side: MaterialStateProperty.all<BorderSide>(
        BorderSide(color: Colors.transparent),
      ));
}
