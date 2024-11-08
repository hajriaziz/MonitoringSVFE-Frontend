import 'package:flutter/material.dart';
import 'package:smtmonitoring/presentation/notification_screen/provider/notification_provider.dart';
import 'package:smtmonitoring/widgets/app_bar/appbar_leading_image.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_trailing_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'models/alertslist_item_model.dart';
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildTodaySection(context),
              SizedBox(height: 12.h),
              _buildAlertsList(context)
            ],
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
        ),
        AppbarTrailingIconbutton(
          imagePath: ImageConstant.imgVector,
          margin: EdgeInsets.only(left: 11.h, top: 15.h, right: 30.h),
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
            itemCount: provider.notificationModelObj.alertslistItemList.length,
            itemBuilder: (context, index) {
              AlertslistItemModel model =
                  provider.notificationModelObj.alertslistItemList[index];
              return AlertslistItemWidget(
                model,
              );
            },
          );
        },
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone(BuildContext context) {
    NavigatorService.goBack();
  }
}
