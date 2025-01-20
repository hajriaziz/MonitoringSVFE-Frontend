import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smtmonitoring/presentation/notification_service.dart';
import 'package:smtmonitoring/presentation/transaction_par_jour_screen/provider/transaction_par_jour_provider.dart';
import 'package:smtmonitoring/presentation/websocket_connection.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_trailing_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class TransactionParJourScreen extends StatefulWidget {
  const TransactionParJourScreen({Key? key})
      : super(
          key: key,
        );
  @override
  TransactionParJourScreenState createState() =>
      TransactionParJourScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Transaction_HistProvider(),
      child: const TransactionParJourScreen(),
    );
  }
}

class TransactionParJourScreenState extends State<TransactionParJourScreen> {
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
      NotificationService.showNotification("Nouvelle Notification", message);
    });

    // Initialise et surveille les permissions de notification
    NotificationService.monitorNotificationPermissions();
    Future.microtask(() async {
      final provider =
          Provider.of<Transaction_HistProvider>(context, listen: false);
      // Retrieve the token from storage
      String? token = await provider.getTokenFromStorage();
      if (token != null && provider.transactionModelObj == null) {
        // Fetch KPIs if the token is found
        provider.fetchKPIs_hist(token).catchError((error) {
          print("Error fetching KPIs hist: $error");
        });
        // Fetch Transaction Trends if the token is found
        provider.fetchTransactionTrends_hist(token).catchError((error) {
          print("Error fetching Transaction Trends hist: $error");
        });
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
        appBar: _buildAppBar(context),
        body: Consumer<Transaction_HistProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.errorMessage != null) {
              return Center(child: Text(provider.errorMessage!));
            } else {
              return _buildTransactionContent(context, provider);
            }
          },
        ),
      ),
    );
  }

  /// Section widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 37.h,
      /*leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 19.h,
          top: 20.h,
          bottom: 19.h,
        ),
        onTap: () {
          onTapArrowlfetone(context);
        },
      ),*/
      title: AppbarSubtitle(
        text: "msg_tat_journali_res".tr,
        margin: EdgeInsets.only(left: 25.h),
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
          },
        ),
      ],
    );
  }

  Widget _buildTransactionContent(
      BuildContext context, Transaction_HistProvider provider) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildDailySummary(context, theme, provider),
          SizedBox(height: 44.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 56.h),
            decoration: AppDecoration.fillLightBlue.copyWith(
              borderRadius: BorderRadiusStyle.customBorderTL50,
            ),
            child: Column(
              children: [
                // The chart widget
                _buildSystemStatus(context, theme),
                SizedBox(
                    height: 14
                        .h), // Add some spacing between chart and the additional widgets
                // Additional widgets under the chart
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgPlay,
                      height: 8.h,
                      width: 8.h,
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 4.h),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 6.h,
                        //right: 10.h,
                      ),
                      child: Text(
                        "lbl_autoris_es".tr,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    Spacer(),
                    CustomImageView(
                      imagePath: ImageConstant.imgPlayRed300,
                      height: 8.h,
                      width: 8.h,
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 4.h),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 6.h,
                        right: 30.h,
                      ),
                      child: Text(
                        "lbl_non_autoris_es2".tr,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section widget
  Widget _buildDailySummary(BuildContext context, ThemeData theme,
      Transaction_HistProvider provider) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 18.h),
      child: Column(
        children: [
          Text(provider.transactionModelObj?.latestUpdate ?? 'N/A',
              style: theme.textTheme.bodyLarge),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 4.h),
            decoration: AppDecoration.fillLightblue50.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorderl4,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("msg_total_transactions".tr,
                    style: theme.textTheme.titleLarge),
                Text(
                  provider.transactionModelObj?.totalTransactions.toString() ??
                      'N/A',
                  style: theme.textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
// Progress bars for Success Rate and Refusal Rate
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                // Success Rate Progress Bar
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                    decoration: AppDecoration.fillLightBlue.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorderl4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 18.h, bottom: 6.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 4.h),
                                  child: Text(
                                    "lbl_transactions".tr,
                                    style: CustomTextStyle.titleMedium18,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.h),
                                  child: Text(
                                    "lbl_autoris_es".tr,
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                // Success Rate Progress Bar
                                Container(
                                  height: 8.h,
                                  width: 124.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.blueGray4005a,
                                    borderRadius: BorderRadius.circular(4.h),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4.h),
                                    child: LinearProgressIndicator(
                                      value: (provider.transactionModelObj
                                                  ?.successRate ??
                                              0) /
                                          100, // Success Rate in range 0.0 to 1.0
                                      backgroundColor: appTheme.blueGray4005a,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        appTheme.tealA700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 6.h),
                        Text(
                          "${provider.transactionModelObj?.successRate ?? 0}%",
                          style: theme.textTheme.titleMedium,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 4.h),

                // Refusal Rate Progress Bar
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.h),
                    decoration: AppDecoration.fillLightBlue.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorderl4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.h, bottom: 8.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 2.h),
                                  child: Text(
                                    "lbl_transactions".tr,
                                    style: CustomTextStyle.titleMedium18,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Padding(
                                  padding: EdgeInsets.only(left: 1.h),
                                  child: Text(
                                    "lbl_non_autoris_es2".tr,
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                // Refusal Rate Progress Bar
                                Container(
                                  height: 8.h,
                                  width: 124.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.blueGray4005a,
                                    borderRadius: BorderRadius.circular(4.h),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4.h),
                                    child: LinearProgressIndicator(
                                      value: (provider.transactionModelObj
                                                  ?.refusalRate ??
                                              0) /
                                          100, // Refusal Rate in range 0.0 to 1.0
                                      backgroundColor: appTheme.blueGray4005a,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        appTheme.redA700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 4.h),
                        Text(
                          "${provider.transactionModelObj?.refusalRate ?? 0}%",
                          style: theme.textTheme.titleMedium,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section widget
  Widget _buildSystemStatus(BuildContext context, ThemeData theme) {
    final provider = Provider.of<Transaction_HistProvider>(context);

    final List<double> successfulTransactions = [];
    final List<double> refusedTransactions = [];
    final List<String> times = [];

    // Populate data lists
    /* for (var trend in provider.transactionTrendshist) {
      times.add(trend.timestamp.toString());
      successfulTransactions.add(trend.successfulTransactions.toDouble());
      refusedTransactions.add(trend.refusedTransactions.toDouble());
    }*/
    // Populate data lists with only one point per hour
    for (var trend in provider.transactionTrendshist) {
      final dateTime = DateTime.parse(trend.timestamp.toString());

      // Only add data for each full hour (e.g., 08:00, 09:00, etc.)
      if (dateTime.minute % 15 == 0) {
        times.add(trend.timestamp.toString());
        successfulTransactions.add(trend.successfulTransactions.toDouble());
        refusedTransactions.add(trend.refusedTransactions.toDouble());
      }
    }

    return Column(
      children: [
        // Chart Title
        Text(
          "msg_l_tat_du_syst_me".tr,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: CustomTextStyle.titleLargeNunitoSansBlack900,
        ),
        SizedBox(height: 10),
        Container(
          height: 300, // Set a height for the chart container
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true), // Display grid lines
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  axisNameWidget: Text(
                    'Transactions',
                    style: CustomTextStyle.titleSmallTeal900SemiBold1,
                  ),
                  axisNameSize: 18,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      // Show transaction counts on the left axis
                      return Text(
                        value.toInt().toString(),
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  axisNameWidget: Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text(
                      'Time',
                      style: CustomTextStyle.titleSmallTeal900SemiBold1,
                    ),
                  ),
                  axisNameSize: 18,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index >= 0 && index < times.length) {
                        final dateTime = DateTime.parse(times[index]);
                        // Display label only for every full hour
                        if (dateTime.minute == 0) {
                          final timeOnly = DateFormat.Hm().format(dateTime);
                          return Text(
                            timeOnly,
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          );
                        }
                      }
                      return const Text(''); // Empty for non-hour markers
                    },
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles:
                      SideTitles(showTitles: false), // Hide the top axis
                ),
                rightTitles: AxisTitles(
                  sideTitles:
                      SideTitles(showTitles: false), // Hide the right axis
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(
                    successfulTransactions.length,
                    (index) =>
                        FlSpot(index.toDouble(), successfulTransactions[index]),
                  ),
                  isCurved: true,
                  color: Color.fromARGB(255, 96, 221, 163),
                  barWidth: 4,
                  belowBarData: BarAreaData(show: false),
                ),
                LineChartBarData(
                  spots: List.generate(
                    refusedTransactions.length,
                    (index) =>
                        FlSpot(index.toDouble(), refusedTransactions[index]),
                  ),
                  isCurved: true,
                  color: Colors.red,
                  barWidth: 4,
                  belowBarData: BarAreaData(show: false),
                ),
              ],
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  bottom:
                      BorderSide(color: Colors.black), // Show bottom axis only
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //Navigates to the previous screen.
  onTapArrowlfetone(BuildContext context) {
    NavigatorService.goBack();
  }

  onTapArrowleftone2(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.notificationScreen);
  }
}
