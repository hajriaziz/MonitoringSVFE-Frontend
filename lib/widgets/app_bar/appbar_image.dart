import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class AppbarImage extends StatelessWidget {
  AppbarImage({Key? key, this.imagePath, this.margin, this.onTap})
      : super(
          key: key,
        );

  final String? imagePath;

  final EdgeInsetsGeometry? margin;

  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        12.h,
      ),
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: SizedBox(
          width: double.maxFinite,
          child: CustomImageView(
            imagePath: imagePath!,
            height: 16.h,
            fit: BoxFit.contain,
            radius: BorderRadius.circular(
              12.h,
            ),
          ),
        ),
      ),
    );
  }
}
