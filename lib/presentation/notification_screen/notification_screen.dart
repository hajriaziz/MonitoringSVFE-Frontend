import 'package:flutter/material.dart';
import 'package:smtmonitoring/presentation/notification_screen/models/notification_model.dart';
import 'package:smtmonitoring/presentation/notification_screen/provider/notification_provider.dart';
import 'package:smtmonitoring/widgets/app_bar/appbar_leading_image.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_trailing_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'widgets/alertslist_item_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key})
      : super(
          key: key,
        );
  @override
  NotificationScreenState createState() => NotificationScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotificationProvider(),
      child: NotificationScreen(),
    );
  }
}

class NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final provider =
          Provider.of<NotificationProvider>(context, listen: false);
      // Retrieve the token from storage
      String? token = await provider.getTokenFromStorage();
      if (token != null) {
        // Fetch KPIs if the token is found
        provider.fetchNotifications().catchError((error) {
          print("Error fetching Alerts: $error");
        });
      } else {
        print("No token found. Please login.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 30.h),
          padding: EdgeInsets.symmetric(
            horizontal: 8.h,
            vertical: 24.h,
          ),
          decoration: AppDecoration.fillLightBlue.copyWith(
            borderRadius: BorderRadiusStyle.customBorderTL70,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTodaySection(context),
                SizedBox(height: 12.h),
                _buildAlertsList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 42.h,
      leadingWidth: 51.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 33.h,
          top: 15.h,
          bottom: 11.h,
        ),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      title: AppbarSubtitle(
        text: "lbl_notification".tr,
        margin: EdgeInsets.only(left: 71.h),
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
          imagePath: ImageConstant.imgVector,
          margin: EdgeInsets.only(left: 11.h, top: 15.h, right: 30.h),
          notificationNotifier: ValueNotifier(false),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildTodaySection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      padding: EdgeInsets.only(left: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_today".tr,
            style: theme.textTheme.bodyMedium,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAlertsList(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 14.h),
      child: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          } else if (provider.notifications.isEmpty) {
            return Center(child: Text("Aucune alerte disponible."));
          } else {
            return ListView.separated(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0.h),
                  child: Divider(
                    height: 1.h,
                    thickness: 1.h,
                    color: appTheme.tealA700,
                  ),
                );
              },
              itemCount: provider.notifications.length,
              itemBuilder: (context, index) {
                NotificationModel notification = provider.notifications[index];

                return Dismissible(
                  key: ValueKey(notification.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    // Appeler removeNotification dans le provider
                    provider.removeNotification(index);
                    // Optionnel : Afficher un message de confirmation
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Notification supprimée')),
                    );
                  },
                  child: AlertslistItemWidget(notification),
                );
              },
            );
          }
        },
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone(BuildContext context) {
    NavigatorService.goBack();
  }
}
