import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_button.dart';
import '../models/notification_model.dart';

class AlertslistItemWidget extends StatelessWidget {
  final NotificationModel notification;

  AlertslistItemWidget(this.notification, {Key? key}) : super(key: key);

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
                imagePath: ImageConstant.imgVector, // Icône par défaut
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
                    "Alerte !", // Texte statique ou configurable
                    style: CustomTextStyle.titleSmallOnErrorContainer,
                  ),
                  Container(
                    width: 216.h,
                    margin: EdgeInsets.only(left: 4.h),
                    child: Text(
                      notification.message,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _formatDateTime(notification.createdAt),
                      style: CustomTextStyle.bodyMediumPoppinsBlueA700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fonction utilitaire pour formater la date
  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute} - ${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
}
