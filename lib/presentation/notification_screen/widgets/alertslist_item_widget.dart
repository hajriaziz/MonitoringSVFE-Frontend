import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_button.dart';
import '../models/alertslist_item_model.dart';

// ignore_for_file: must_be_immutable
class AlertslistItemWidget extends StatelessWidget {
  AlertslistItemWidget(this.alertslistItemModelObj, {Key? key})
      : super(
          key: key,
        );
  AlertslistItemModel alertslistItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 12.h,
        right: 6.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: CustomIconButton(
              height: 36.h,
              width: 36.h,
              padding: EdgeInsets.all(4.h),
              decoration: IconButtonStyleHelper.fillTealA,
              child: CustomImageView(
                imagePath: alertslistItemModelObj.muteIcon!,
              ),
            ),
          ),
          SizedBox(width: 6.h),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alertslistItemModelObj.alertText!,
                    style: CustomTextStyle.titleSmallOnErrorContainer,
                  ),
                  Container(
                    width: 216.h,
                    margin: EdgeInsets.only(left: 4.h),
                    child: Text(
                      alertslistItemModelObj.anomalyText!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      alertslistItemModelObj.timeText!,
                      style: CustomTextStyle.bodyMediumPoppinsBlueA700,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
