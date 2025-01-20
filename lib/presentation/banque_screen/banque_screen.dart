import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smtmonitoring/presentation/notification_service.dart';
import 'package:smtmonitoring/presentation/websocket_connection.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_trailing_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'provider/banque_provider.dart';

class BanqueScreen extends StatefulWidget {
  const BanqueScreen({Key? key})
      : super(
          key: key,
        );

  @override
  BanqueScreenState createState() => BanqueScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BanqueProvider(),
      child: const BanqueScreen(),
    );
  }
}

final Map<String, String> criticalCodeDescriptions = {
  '802': 'CBS is not available (Issuer Inoperative)',
  '801': 'Network didn’t respond, timer time-out.',
  '840': 'Stand-in processing not permitted',
  // Ajoutez d'autres descriptions ici
};

class BanqueScreenState extends State<BanqueScreen> {
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
      final provider = Provider.of<BanqueProvider>(context, listen: false);

      // Récupérer le token et charger les données si le token est valide
      String? token = await provider.getTokenFromStorage();
      if (token != null) {
        provider
            .fetchAllData(); // Appeler fetchAllData pour récupérer KPIs et RefusalRate
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
        body: Consumer<BanqueProvider>(
          builder: (context, banqueProvider, child) {
            if (banqueProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (banqueProvider.errorMessage != null) {
              return Center(child: Text(banqueProvider.errorMessage!));
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTransactionSummary(context, banqueProvider),
                    SizedBox(height: 20),
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.h, vertical: 56.h),
                      decoration: AppDecoration.fillLightBlue.copyWith(
                        borderRadius: BorderRadiusStyle.customBorderTL50,
                      ),
                      child: _buildTopRefusalRateChart(
                          context, banqueProvider, theme),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  /// Section widget
  PreferredSizeWidget _buildTopBar(BuildContext context) {
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
          onTapArrowleftone(context);
        },
      ),*/
      title: AppbarSubtitle(
        text: "lbl_banque_metteur".tr,
        margin: EdgeInsets.only(left: 64.h),
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

  /// Section Widget
  Widget _buildTransactionSummary(
      BuildContext context, BanqueProvider banqueProvider) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 18.h),
      child: Column(
        children: [
          Text(
            banqueProvider.kpisData?.latestUpdate ?? 'N/A',
            style: theme.textTheme.bodyLarge,
          ),
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
                Text(
                  "msg_total_transactions".tr,
                  style: theme.textTheme.titleLarge,
                ),
                Text(
                  banqueProvider.kpisData?.totalTransactions.toString() ??
                      'N/A',
                  style: theme.textTheme.headlineSmall,
                )
              ],
            ),
          ),
          SizedBox(height: 24.h),
          // Row for left and right containers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container on the Left
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.h, vertical: 10.h),
                  decoration: AppDecoration.fillLightBlue.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorderl8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Code de réponse le plus fréquent",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        banqueProvider.kpisData?.mostFrequentRefusalCode
                                .toString() ??
                            'N/A',
                        style: CustomTextStyle.bodyLargeRedA700,
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Nombre T :",
                            style: theme.textTheme.bodyLarge,
                          ),
                          SizedBox(width: 8.h),
                          Text(
                            banqueProvider.kpisData?.mostFrequentRefusalCount
                                    .toString() ??
                                'N/A',
                            style: CustomTextStyle.bodyLargeRedA700,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16.h), // Space between the containers

              // Container on the Right
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.h, vertical: 10.h),
                  decoration: AppDecoration.fillLightblue50.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorderl8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Taux de refus par rapport aux codes critiques",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 10.h),
                      ...banqueProvider.kpisData?.criticalCodeRates.entries
                              .map((entry) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Tooltip(
                                    message: criticalCodeDescriptions[
                                            entry.key] ??
                                        "Aucune description pour le code critique ${entry.key}.",
                                    child: Icon(
                                      Icons.info_outline,
                                      size: 18.h,
                                      color: Color.fromARGB(255, 201, 17, 17),
                                    ),
                                  ),
                                  Text(
                                    "Code ${entry.key} :",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                  Text(
                                    "${entry.value.toStringAsFixed(2)}%", // Affiche la valeur correctement
                                    style: CustomTextStyle.bodyLargeRedA700,
                                  ),
                                ],
                              ),
                            );
                          }).toList() ??
                          [
                            Center(
                              child: Text(
                                'Aucun code critique disponible.',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 22.h),

          // Other containers or widgets below...
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTopRefusalRateChart(
      BuildContext context, BanqueProvider banqueProvider, ThemeData theme) {
    // Obtenez les 5 banques avec les taux de refus les plus élevés
    final refusalRates = banqueProvider.refusalRateData?.rates ?? {};
    final topRefusalRates = refusalRates.entries.toList()
      ..sort((a, b) =>
          b.value.compareTo(a.value)); // Trier du plus grand au plus petit
    final top5RefusalRates =
        topRefusalRates.take(5).toList(); // Prendre les 5 premiers

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 10.h),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 4.h),
                Text(
                  "msg_top_5_des_banques".tr,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.titleLargeNunitoSansBlack900,
                ),
                SizedBox(height: 40.h),
                Container(
                  width: double.infinity,
                  height: 250.h, // Définir une hauteur pour le graphique
                  margin: EdgeInsets.symmetric(horizontal: 10.h),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      barGroups: top5RefusalRates.map((entry) {
                        int index = top5RefusalRates.indexOf(entry);
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: entry.value.toDouble(), // Taux de refus
                              color: Colors.red, // Couleur pour la barre
                              width: 18.h, // Largeur de la barre
                            ),
                          ],
                        );
                      }).toList(),
                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                          sideTitles:
                              SideTitles(showTitles: false), // Hide top title
                        ),
                        rightTitles: AxisTitles(
                          sideTitles:
                              SideTitles(showTitles: false), // Hide right title
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              final issuerCode =
                                  top5RefusalRates[value.toInt()].key;
                              return Text(issuerCode,
                                  style: theme.textTheme.bodySmall);
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval:
                                10, // Ajustez l’intervalle selon les données
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text('${value.toInt()}%',
                                  style: theme.textTheme.bodyLarge);
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: true),
                      barTouchData: BarTouchData(enabled: true),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///Navigates to the previous screen.
  onTapArrowleftone(BuildContext context) {
    NavigatorService.goBack();
  }

  onTapArrowleftone2(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.notificationScreen);
  }
}
