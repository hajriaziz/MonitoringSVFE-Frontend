import 'package:flutter/material.dart';
import 'package:smtmonitoring/core/app_export.dart';
import 'package:smtmonitoring/core/utils/image_constant.dart';
import 'package:smtmonitoring/theme/theme_helper.dart';

enum BottomBarEnum { Home, AnalyseActule, Terminal, Journaliee, Profil, Bank }

// ignore_for_file: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

// ignore: duplicate_ignore
// ignore_for_file: must_be_immutable
class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedlndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgThumbsUp,
      activeIcon: ImageConstant.imgThumbsUp,
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgSettings,
      activeIcon: ImageConstant.imgSettings,
      type: BottomBarEnum.AnalyseActule,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgQuestion,
      activeIcon: ImageConstant.imgQuestion,
      type: BottomBarEnum.Terminal,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgThumbsUpBlack900,
      activeIcon: ImageConstant.imgThumbsUpBlack900,
      type: BottomBarEnum.Journaliee,
    ),
    BottomMenuModel(
      icon: ImageConstant.imageBank,
      activeIcon: ImageConstant.imageBank,
      type: BottomBarEnum.Bank,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgUser,
      activeIcon: ImageConstant.imgUser,
      type: BottomBarEnum.Profil,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114.h,
      decoration: BoxDecoration(
        color: appTheme.blue200,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.h),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedlndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: bottomMenuList[index].icon,
              height: 30.h,
              width: 30.h,
              //color: theme.colorScheme.onErrorContainer,
            ),
            activeIcon: CustomImageView(
              imagePath: bottomMenuList[index].activeIcon,
              height: 30.h,
              width: 24.h,
              color: appTheme.lightBlue50,
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedlndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

// ignore: duplicate_ignore
// ignore_for_file: must_be_immutable
class BottomMenuModel {
  BottomMenuModel(
      {required this.icon, required this.activeIcon, required this.type});

  String icon;

  String activeIcon;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
