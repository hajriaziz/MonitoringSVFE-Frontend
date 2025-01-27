import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smtmonitoring/core/app_export.dart';
import 'package:smtmonitoring/presentation/backgroundservice%20.dart';
import 'package:smtmonitoring/presentation/notification_service.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.initialize();
  await NotificationService.requestNotificationPermission();

  initializeBackgroundService();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
          child: Consumer<ThemeProvider>(
            builder: (context, provider, child) {
              return MaterialApp(
                title: 'smtmonitoring',
                debugShowCheckedModeBanner: false,
                theme: theme,
                navigatorKey: NavigatorService.navigatorKey,
                localizationsDelegates: [
                  AppLocalizationDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                supportedLocales: [
                  Locale('en', ''), // Anglais
                  Locale('fr', 'FR'), // Français
                ],
                locale: Locale('en', ''), // Définir la locale en français par défaut
                initialRoute: AppRoutes.initialRoute,
                routes: AppRoutes.routes,
              );
            },
          ),
        );
      },
    );
  }
}
