import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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

class BanqueScreenState extends State<BanqueScreen> {
  @override
  void initState() {
    super.initState();
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
        ),
        AppbarTrailingIconbutton(
          imagePath: ImageConstant.imgVector,
          margin: EdgeInsets.only(
            left: 11.h,
            top: 15.h,
            right: 30.h,
          ),
          onTap: () {
            onTapArrowleftone2(context);
          },
        )
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
            "msg_29_juillet_10_02".tr,
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.maxFinite,
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
          SizedBox(height: 22.h),
          Container(
            width: 165.h,
            //height: 155.h,
            margin: EdgeInsets.only(bottom: 32.h),
            padding: EdgeInsets.symmetric(horizontal: 18.h),
            decoration: AppDecoration.fillLightBlue.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorderl8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 6.h),
                Text(
                  "Code de réponse le plus fréquent",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 10.h),
                Text(
                  banqueProvider.kpisData?.mostFrequentRefusalCode.toString() ??
                      'N/A',
                  style: CustomTextStyle.bodyLargeRedA700,
                ),
                SizedBox(height: 6.h),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Nombre T :",
                        style: theme.textTheme.bodyLarge,
                      ),
                      SizedBox(width: 14.h),
                      Text(
                        banqueProvider.kpisData?.mostFrequentRefusalCount
                                .toString() ??
                            'N/A',
                        style: CustomTextStyle.bodyLargeRedA700,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
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
      padding: EdgeInsets.symmetric(horizontal: 15.h),
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
                  margin: EdgeInsets.symmetric(horizontal: 20.h),
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
                              width: 20.h, // Largeur de la barre
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
                                  style: theme.textTheme.bodyLarge);
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
