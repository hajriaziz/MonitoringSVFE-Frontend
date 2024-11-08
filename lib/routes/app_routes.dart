import 'package:flutter/material.dart';
import 'package:smtmonitoring/presentation/banque_screen/banque_screen.dart';
import 'package:smtmonitoring/presentation/barnav_container_screen/barnav_container_screen.dart';
import 'package:smtmonitoring/presentation/launch_screen/launch_screen.dart';
import 'package:smtmonitoring/presentation/login_screen/login_screen.dart';
import 'package:smtmonitoring/presentation/notification_screen/notification_screen.dart';
import 'package:smtmonitoring/presentation/profile_screen/profile_screen.dart';
import 'package:smtmonitoring/presentation/terminal_screen/terminal_screen.dart';
import 'package:smtmonitoring/presentation/transaction_par_jour_screen/transaction_par_jour_screen.dart';
import 'package:smtmonitoring/presentation/transaction_screen/transaction_screen.dart';

class AppRoutes {
  static const String launchScreen = '/launch_screen';
  static const String loginScreen = '/login_screen';
  static const String transactionScreen = '/transaction_screen';
  static const String terminalScreen = '/terminal_screen';
  static const String transactionParJourScreen = '/transaction_par_jour_screen';
  static const String banqueScreen = '/banque_screen';
  static const String barnavContainerScreen = '/barnav_container_screen';
  static const String barnavPage = '/barnav_page';
  static const String notificationScreen = '/notification_screen';
  static const String transactionAlerteScreen = '/transaction_alerte_screen';
  static const String alerteTerminalScreen = '/alerte_terminal_screen';
  static const String appNavigationScreen = '/app_navigation_screen';
  static const String profileScreen = '/profile_screen';
  static const String initialRoute = '/initialRoute';
  static Map<String, WidgetBuilder> get routes => {
        launchScreen: LaunchScreen.builder,
        loginScreen: LoginScreen.builder,
        transactionScreen: TransactionScreen.builder,
        profileScreen: PorfileScreen.builder,
        terminalScreen: TerminalScreen.builder,
        transactionParJourScreen: TransactionParJourScreen.builder,
        banqueScreen: BanqueScreen.builder,
        barnavContainerScreen: BarnavContainerScreen.builder,
        notificationScreen: NotificationScreen.builder,
        //transactionAlerteScreen: TransactionAlerteScreen.builder,
        //alerteTerminalScreen: AlerteTerminalScreen.builder,
        //appNavigationScreen: AppNavigationScreen.builder,
        initialRoute: LaunchScreen.builder
      };
}
