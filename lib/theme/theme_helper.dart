import 'package:flutter/material.dart';
import 'package:smtmonitoring/core/app_export.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // The current app theme
  var _appTheme = PrefUtils().getThemeData();

// A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Returns the lic-tCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current there data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.blue200,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.gray300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 0,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.gray200,
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: appTheme.gray60001,
          fontSize: 16.fSize,
          fontFamily: 'Nunito Sans',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: colorScheme.onErrorContainer,
          fontSize: 14.fSize,
          fontFamily: 'League Spartan',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: appTheme.gray60001,
          fontSize: 12.fSize,
          fontFamily: 'Nunito Sans',
          fontWeight: FontWeight.w400,
        ),
        displayMedium: TextStyle(
          color: appTheme.lightBlue700,
          fontSize: 37.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        headlineLarge: TextStyle(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 30.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 24.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
          color: appTheme.blue700,
          fontSize: 12.fSize,
          fontFamily: 'Nunito Sans',
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          color: appTheme.gray800,
          fontSize: 20.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: appTheme.black900,
          fontSize: 16.fSize,
          fontFamily: 'Nunito Sans',
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 14.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFFB8DFF5),
    primaryContainer: Color(0XFF4B4544),
    secondaryContainer: Color(0XFFEEEEEE),
    errorContainer: Color(0XFF3299FF),
    onError: Color(0XFFE3E4E8),
    onErrorContainer: Color(0XFF052224),
    onPrimary: Color(0X72093030),
    onPrimaryContainer: Color(0XFFFFFFFF),
  );
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  // Black
  Color get black900 => Color(0XFF000000);
  // Blue
  Color get blue200 => Color(0XFF88CAEF);
  Color get blue700 => Color(0XFF147AD6);
  Color get blueA700 => Color(0XFF0068FF);
  // BlueGray
  Color get blueGray100 => Color(0XFFD6D8DB);
  Color get blueGray400 => Color(0XFF7C828A);
  // BlueGraya
  Color get blueGray4005a => Color(0X5A7388A9);
  // Cyan
  Color get cyan200 => Color(0XFF78D2DD);
  Color get cyan90019 => Color(0X1906595C);
  // Gray
  Color get gray100 => Color(0XFFF1FFF2);
  Color get gray200 => Color(0XFFE8E8E8);
  Color get gray300 => Color(0XFFDBE8E8);
  Color get gray50 => Color(0XFFF8F8F8);
  Color get gray500 => Color(0XFFAAAAAA);
  Color get gray600 => Color(0XFF6D7278);
  Color get gray60001 => Color(0XFF788189);
  Color get gray800 => Color(0XFF4C4848);
  // LightBlue
  Color get lightBlue50 => Color(0XFFE8FEFF);
  Color get lightBlue5001 => Color(0XFFE9FEFF);
  Color get lightBlue700 => Color(0XFF0386D0);
  // Red
  Color get red300 => Color(0XFFEC6666);
  Color get redA700 => Color(0XFFFF0000);
  //Teal
  Color get teal900 => Color(0XFF0E3E3E);
  Color get tealA700 => Color(0XFF00D09E);
}
