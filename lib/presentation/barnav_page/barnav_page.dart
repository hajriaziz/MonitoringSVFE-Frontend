import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'provider/barnav_provider.dart';
// ignore_for_file: must_be_immutable

class BarnavPage extends StatefulWidget {
  const BarnavPage({Key? key})
      : super(
          key: key,
        );

  @override
  BarnavPageState createState() => BarnavPageState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BarnavProvider(),
      child: BarnavPage(),
    );
  }
}

class BarnavPageState extends State<BarnavPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.lightBlue50,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                height: 350.h,
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 102.h),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    _buildRowSmtMonitoring(context),
                    CustomImageView(
                      imagePath: ImageConstant.imgAnalyseMobilel,
                      height: 158.h,
                      width: 158.h,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 32.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 12.h,
                  vertical: 28.h,
                ),
                decoration: BoxDecoration(
                    color: appTheme.blue200,
                    borderRadius: BorderRadiusStyle.roundedBorderl4),
                width: double.maxFinite,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgProfil,
                      height: 60.h,
                      width: 56.h,
                      radius: BorderRadius.circular(
                        28.h,
                      ),
                      alignment: Alignment.center,
                    ),
                    SizedBox(width: 10.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Aziz Hajri",
                            style: CustomTextStyle.titleLargeOnPrimaryBold,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "ID: ",
                                  style: CustomTextStyle
                                      .labelLargePoppinsOnPrimarySemi8old,
                                ),
                                TextSpan(
                                  text: "2503024",
                                  style: CustomTextStyle
                                      .bodyMediumPoppinsOnPrimary,
                                )
                              ],
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widge
  Widget _buildRowSmtMonitoring(BuildContext context) {
    return Container(
      height: 68.h,
      margin: EdgeInsets.only(top: 148.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "lbl_smtmonitoring".tr,
            style: theme.textTheme.displayMedium,
          )
        ],
      ),
    );
  }
}
