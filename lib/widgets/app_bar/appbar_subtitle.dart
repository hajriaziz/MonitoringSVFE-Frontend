import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class AppbarSubtitle extends StatelessWidget {
  AppbarSubtitle({Key? key, required this.text, this.margin, this.onTap})
      : super(
          key: key,
        );
  final String text;
  final EdgeInsetsGeometry? margin;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: SizedBox(
          width: 220.h,
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyle.titleMediumPoppinsOnPrimary.copyWith(
              //style: theme.textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.onPrimary.withOpacity(1),
              height: 1.22,
            ),
          ),
        ),
      ),
    );
  }
}
