import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/listcodederepon_item_model.dart';

// ignore_for_file: must_be_immutable
class ListcodedereponItemWidget extends StatelessWidget {
  ListcodedereponItemWidget(this.listcodedereponItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ListcodedereponItemModel listcodedereponItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            listcodedereponItemModelObj.codeDeReponse!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          Text(
            listcodedereponItemModelObj.additionalText!,
            style: CustomTextStyle.bodyLargeRedA700,
          ),
          SizedBox(height: 6.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  listcodedereponItemModelObj.nombreT!,
                  style: theme.textTheme.bodyLarge,
                ),
                SizedBox(width: 14.h),
                Text(
                  listcodedereponItemModelObj.additionaltextg!,
                  style: CustomTextStyle.bodyLargeRedA700,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
