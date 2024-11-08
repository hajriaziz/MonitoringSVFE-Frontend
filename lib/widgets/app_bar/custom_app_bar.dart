import 'package:flutter/material.dart';
import '../../core/app_export.dart';

enum Style { bgShadow }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {Key? key,
      this.height,
      this.styleType,
      this.leadingWidth,
      this.leading,
      this.title,
      this.centerTitle,
      this.actions})
      : super(
          key: key,
        );

  final double? height;

  final double? styleType;

  final double? leadingWidth;

  final Widget? leading;

  final Widget? title;

  final bool? centerTitle;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height ?? 56.h,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        SizeUtils.width,
        height ?? 56.h,
      );
  _getStyle() {
    switch (styleType) {
      // ignore: constant_pattern_never_matches_value_type
      case Style.bgShadow:
        return Container(
          height: 24.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: appTheme.blue200,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24.h),
              ),
              boxShadow: [
                BoxShadow(
                  color: appTheme.black900.withOpacity(0.16),
                  spreadRadius: 2.h,
                  blurRadius: 2.h,
                  offset: Offset(
                    0,
                    2,
                  ),
                )
              ]),
        );
      default:
        return null;
    }
  }
}
