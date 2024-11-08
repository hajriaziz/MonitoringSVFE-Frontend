//import 'package:flutter/material.dart';
//import '../../core/app_export.dart';
//import '../../theme/custom_button_style.dart';
//import '../../widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:smtmonitoring/core/app_export.dart';
import 'package:smtmonitoring/presentation/launch_screen/provider/launch_provider.dart';
//import 'provider/launch_provider.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key})
      : super(
          key: key,
        );
  @override
  LaunchScreenState createState() => LaunchScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LaunchProvider(),
      child: LaunchScreen(),
    );
  }
}

class LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 5000), () {
      NavigatorService.popAndPushNamed(
        AppRoutes.loginScreen,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.lightBlue50,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(18.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 86.h),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 28.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgAnalyseMobilel,
                        height: 158.h,
                        width: 158.h,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 58.h),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "lbl_smtmonitoring".tr,
                        style: theme.textTheme.displayMedium,
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Text(
                          "msg_monitor_detecta".tr,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: CustomTextStyle
                              .bodyLargeLeagueSpartanPrimaryContainer,
                        ),
                      ),
                      /*SizedBox(height: 32.h),
                        CustomElevatedButton(
                          text: "lbl_log_in".tr,
                          margin: EdgeInsets.only(
                            left: 48.h,
                            right: 50.h,
                          ),
                        ),*/
                      /*SizedBox(height: 12.h),
                        CustomElevatedButton(
                          text: "lbl_sign_up".tr,
                          margin: EdgeInsets.only(
                            left: 48.h,
                            right: 50.h,
                          ),
                          buttonStyle: CustomButtonStyles.fillPrimary,
                          buttonTextStyle:
                              CustomTextStyles.titleLargeOnSecondaryContainer,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "msg_forgot_password".tr,
                          style: CustomTextStyles.titleSmallLeagueSpartanOnPrimary,
                        )*/
                      Spacer(),
                      CustomImageView(
                        imagePath: ImageConstant.imageMonetiique,
                        height: 90.h,
                        width: 224.h,
                        radius: BorderRadius.circular(
                          4.h,
                        ),
                        margin: EdgeInsets.only(right: 30.h),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
