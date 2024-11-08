import 'package:flutter/material.dart';
import 'package:smtmonitoring/presentation/transaction_screen/models/listtitle_item_model.dart';
import '../../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class ListtitleItemWidget extends StatelessWidget {
  ListtitleItemWidget(this.listtitleItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ListtitleItemModel listtitleItemModelObj;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 173.h,
      padding: EdgeInsets.symmetric(
        horizontal: 4.h,
        vertical: 2.h,
      ),
      decoration: AppDecoration.fillLightBlue.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorderl4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 18.h,
                bottom: 6.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text(
                      listtitleItemModelObj.title!,
                      style: CustomTextStyle.titleMedium18,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text(
                      listtitleItemModelObj.additionalText!,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    height: 8.h,
                    width: 124.h,
                    decoration: BoxDecoration(
                      color: appTheme.blueGray4005a,
                      borderRadius: BorderRadius.circular(
                        4.h,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        4.h,
                      ),
                      child: LinearProgressIndicator(
                        value: 0.56,
                        backgroundColor: appTheme.blueGray4005a,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          appTheme.tealA700,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 6.h),
          Text(
            listtitleItemModelObj.percentage!,
            style: theme.textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
