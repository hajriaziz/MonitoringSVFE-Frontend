import 'package:flutter/material.dart';
import 'package:smtmonitoring/presentation/banque_screen/banque_screen.dart';
import 'package:smtmonitoring/presentation/profile_screen/profile_screen.dart';
import 'package:smtmonitoring/presentation/terminal_screen/terminal_screen.dart';
import 'package:smtmonitoring/presentation/transaction_par_jour_screen/transaction_par_jour_screen.dart';
import 'package:smtmonitoring/presentation/transaction_screen/transaction_screen.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../barnav_page/barnav_page.dart';
import 'provider/barnav_container_provider.dart';

class BarnavContainerScreen extends StatefulWidget {
  const BarnavContainerScreen({Key? key})
      : super(
          key: key,
        );
  @override
  BarnavContainerScreenState createState() => BarnavContainerScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BarnavContainerProvider(),
      child: BarnavContainerScreen(),
    );
  }
}

// ignore_for_file: must_be_immutable
class BarnavContainerScreenState extends State<BarnavContainerScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.lightBlue50,
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.barnavPage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, anii) =>
                getCurrentPage(context, routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: double.maxFinite,
          child: _buildBottomNavigation(context),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigation(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          Navigator.pushNamed(
              navigatorKey.currentContext!, getCurrentRoute(type));
        },
      ),
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.barnavPage;
      case BottomBarEnum.AnalyseActule:
        return AppRoutes.transactionScreen;
      case BottomBarEnum.Terminal:
        return AppRoutes.terminalScreen;
      case BottomBarEnum.Journaliee:
        return AppRoutes.transactionParJourScreen;
      case BottomBarEnum.Bank:
        return AppRoutes.banqueScreen;
      case BottomBarEnum.Profil:
        return AppRoutes.profileScreen;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.barnavPage:
        return BarnavPage.builder(context);
      case AppRoutes.transactionScreen:
        return TransactionScreen.builder(context);
      case AppRoutes.profileScreen:
        return ProfileScreen.builder(context);
      case AppRoutes.terminalScreen:
        return TerminalScreen.builder(context);
      case AppRoutes.transactionParJourScreen:
        return TransactionParJourScreen.builder(context);
      case AppRoutes.banqueScreen:
        return BanqueScreen.builder(context);
      default:
        return DefaultWidget();
    }
  }
}
