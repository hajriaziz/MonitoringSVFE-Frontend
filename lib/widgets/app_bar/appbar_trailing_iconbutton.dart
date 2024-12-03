import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../custom_icon_button.dart';

class AppbarTrailingIconbutton extends StatelessWidget {
  AppbarTrailingIconbutton({Key? key, this.imagePath, this.margin, this.onTap,
  required this.notificationNotifier, // Ajout du ValueNotifier
  this.imagePathNotification,})
      : super(key: key);

  final String? imagePath;

  final ValueNotifier<bool> notificationNotifier; // Notifie l'état des notifications

  final String? imagePathNotification; // Icône en cas de notification


  final EdgeInsetsGeometry? margin;

  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: notificationNotifier,
      builder: (context, hasNotification, child) {
        return GestureDetector(
          onTap: () {
            onTap?.call();
            // Réinitialise l'état des notifications à false après le clic
            notificationNotifier.value = false;
          },
          child: Padding(
            padding: margin ?? EdgeInsets.zero,
            child: CustomIconButton(
              height: 30.h,
              width: 30.h,
              padding: EdgeInsets.all(4.h),
              child: CustomImageView(
                imagePath: hasNotification
                    ? imagePathNotification // Icône lorsque notification active
                    : imagePath, // Icône par défaut
              ),
            ),
          ),
        );
      },
    );
  }
}
