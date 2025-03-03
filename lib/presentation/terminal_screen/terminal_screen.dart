import 'package:flutter/material.dart';
import 'package:smtmonitoring/presentation/notification_service.dart';
import 'package:smtmonitoring/presentation/websocket_connection.dart';
//import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_trailing_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'provider/terminal_provider.dart';
import 'package:fl_chart/fl_chart.dart';

class TerminalScreen extends StatefulWidget {
  const TerminalScreen({Key? key}) : super(key: key);

  @override
  TerminalScreenState createState() => TerminalScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TerminalProvider(),
      child: const TerminalScreen(),
    );
  }
}

class TerminalScreenState extends State<TerminalScreen> {
  final WebSocketService webSocketService = WebSocketService();
  @override
  void initState() {
    super.initState();
    // Démarrez le service WebSocket
    webSocketService.connect();

    // Écoutez les notifications entrantes et déclenchez l'état de notification
    webSocketService.messages.listen((message) {
      webSocketService.hasNotification.value = true;
      // Affiche une notification locale avec le message reçu
      //NotificationService.showNotification("Nouvelle Notification", message);
    });

    // Initialise et surveille les permissions de notification
    NotificationService.monitorNotificationPermissions();

    Future.microtask(() async {
      final provider = Provider.of<TerminalProvider>(context, listen: false);

      // Retrieve the token and fetch terminal distribution if needed
      String? token = await provider.getTokenFromStorage();
      if (token != null && provider.terminalDistribution == null) {
        provider.fetchTerminalDistribution();
      } else {
        print("No token found. Please login.");
      }
    });
  }

  @override
  void dispose() {
    // Déconnectez le WebSocket
    webSocketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildTopBar(context),
        body: Consumer<TerminalProvider>(
          builder: (context, terminalProvider, child) {
            if (terminalProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (terminalProvider.errorMessage != null) {
              return Center(child: Text(terminalProvider.errorMessage!));
            } else {
              return _buildTerminalContent(context, terminalProvider);
            }
          },
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildTopBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 37.h,
      /*leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 19.h,
          top: 19.h,
          bottom: 20.h,
        ),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),*/
      centerTitle: true,
      title: AppbarSubtitle(
        text: "msg_tat_des_terminaux".tr,
      ),
      actions: [
        AppbarTrailingIconbutton(
          imagePath: ImageConstant.imgChat,
          margin: EdgeInsets.only(
            top: 15.h,
            right: 10.h,
          ),
          notificationNotifier: ValueNotifier(false),
        ),
        AppbarTrailingIconbutton(
          imagePath: ImageConstant.imgVector, // Icône par défaut
          imagePathNotification:
              ImageConstant.imgAlert, // Icône de notification
          margin: EdgeInsets.only(
            left: 11.h,
            top: 15.h,
            right: 30.h,
          ),
          notificationNotifier:
              webSocketService.hasNotification, // Gestion dynamique
          onTap: () {
            // Réinitialise l'état des notifications après clic
            webSocketService.resetNotificationState();
            onTapArrowleftone2(context);
            ;
          },
        ),
      ],
    );
  }

  Widget _buildTerminalContent(
      BuildContext context, TerminalProvider terminalProvider) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTransactionSummary(context, terminalProvider),
          SizedBox(height: 62.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 56.h),
            decoration: AppDecoration.fillLightBlue.copyWith(
              borderRadius: BorderRadiusStyle.customBorderTL50,
            ),
            child: _buildChartSection(context, terminalProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionSummary(
      BuildContext context, TerminalProvider terminalProvider) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 18.h),
      padding: EdgeInsets.symmetric(horizontal: 18.h),
      child: Column(
        children: [
          Text(
            terminalProvider.terminalDistribution?.latestUpdate.toString() ??
                'N/A',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 36.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(right: 18.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 98.h,
                    margin: EdgeInsets.only(bottom: 4.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgATM,
                          height: 60.h,
                          width: 56.h,
                          margin: EdgeInsets.only(right: 12.h),
                        ),
                        SizedBox(height: 22.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              terminalProvider.terminalDistribution?.dab
                                      .toString() ??
                                  '0',
                              style:
                                  CustomTextStyle.titleMediumInterBluegray400_1,
                            ),
                            Text(
                              "lbl_transaction".tr,
                              style:
                                  CustomTextStyle.titleMediumInterBluegray400_1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //SizedBox(width: 12.h),
                //vertical line
                Container(
                  width: 1.2, // Thin width for the divider
                  height: 130.h, // Adjust height to fit your content
                  color: appTheme.gray100, // Same color as before
                  margin: EdgeInsets.symmetric(horizontal: 12.h),
                ),
                //SizedBox(width: 8.h),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgTPE,
                                    height: 60.h,
                                    width: 60.h,
                                    alignment: Alignment.center,
                                  ),
                                  Container(
                                    width: 100.h,
                                    margin: EdgeInsets.only(
                                      left: 12.h,
                                      top: 2.h,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          terminalProvider
                                                  .terminalDistribution?.tpe
                                                  .toString() ??
                                              '0',
                                          style: CustomTextStyle
                                              .titleMediumInterBluegray400_1,
                                        ),
                                        Text(
                                          "lbl_transaction".tr,
                                          style: CustomTextStyle
                                              .titleMediumInterBluegray400_1,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            //horiztal line
                            SizedBox(
                              width: double.maxFinite,
                              child: Divider(
                                thickness: 1.2.h,
                                color: appTheme.gray100,
                                endIndent: 6.h,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(
                          left: 6.h,
                          right: 8.h,
                        ),
                        child: Row(
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgECo,
                              height: 52.h,
                              width: 46.h,
                            ),
                            SizedBox(width: 24.h),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: 70.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      terminalProvider
                                              .terminalDistribution?.eCommerce
                                              .toString() ??
                                          '0',
                                      style: CustomTextStyle
                                          .titleMediumInterBluegray400_1,
                                    ),
                                    Text(
                                      "lbl_transaction".tr,
                                      style: CustomTextStyle
                                          .titleMediumInterBluegray400_1,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildChartSection(
    BuildContext context, TerminalProvider terminalProvider) {
  // Extract refusal rates for the chart
  final refusalRates = terminalProvider.terminalDistribution?.refusalRateByChannel ?? {};

  // Extract the rates for each terminal type
  final dabRate = refusalRates['1'] ?? 0.0; // DAB
  final tpeRate = refusalRates['2'] ?? 0.0; // TPE
  final eComRate = refusalRates['8'] ?? 0.0; // E-commerce

  // Create a list of PieChartSections
  List<PieChartSectionData> _generateSections() {
    return [
      PieChartSectionData(
        value: dabRate,
        title: '${dabRate.toStringAsFixed(1)}%', // Show percentage
        color: const Color(0xff0293ee),
        radius: 50,
        titleStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        value: tpeRate,
        title: '${tpeRate.toStringAsFixed(1)}%', // Show percentage
        color: const Color(0xfff8b250),
        radius: 50,
        titleStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        value: eComRate,
        title: '${eComRate.toStringAsFixed(1)}%', // Show percentage
        color: const Color(0xff845bef),
        radius: 50,
        titleStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ];
  }

  return Container(
    width: double.maxFinite,
    padding: EdgeInsets.symmetric(horizontal: 18.h),
    child: Column(
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 18.h),
          decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorderl4,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 6.h),
              Text(
                "msg_les_terminaux_par".tr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyle.titleMedium18,
              ),
              SizedBox(height: 2.h),
              Container(
                height: 174.h,
                width: 174.h,
                child: PieChart(
                  PieChartData(
                    sections: _generateSections(),
                    centerSpaceRadius: 40, // Space in the center
                    sectionsSpace: 2, // Space between sections
                  ),
                ),
              ),
              SizedBox(height: 26.h),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLegend("DAB", Color(0xff0293ee)),
                    _buildLegend("TPE", Color(0xfff8b250)),
                    _buildLegend("E-Com", Color(0xff845bef)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper widget to build the legend
Widget _buildLegend(String label, Color color) {
  return Row(
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      SizedBox(width: 8),
      Text(label, style: CustomTextStyle.titleMediumInterBluegray400_1),
    ],
  );
}


  /// Navigates to the previous screen.
  onTapArrowleftone(BuildContext context) {
    NavigatorService.goBack();
  }

  onTapArrowleftone2(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.notificationScreen);
  }
}
