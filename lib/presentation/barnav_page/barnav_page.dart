import 'package:flutter/material.dart';
import 'package:smtmonitoring/presentation/api_service.dart';
import 'package:smtmonitoring/presentation/profile_screen/provider/profile_provider.dart';
import '../../core/app_export.dart';

class BarnavPage extends StatefulWidget {
  const BarnavPage({Key? key})
      : super(
          key: key,
        );

  @override
  BarnavPageState createState() => BarnavPageState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(apiService: ApiService()),
      child: BarnavPage(),
    );
  }
}

class BarnavPageState extends State<BarnavPage> {
  @override
  void initState() {
    super.initState();
    // Use Future.microtask to ensure the provider context is available before making the call
    Future.microtask(() async {
      final provider = Provider.of<ProfileProvider>(context, listen: false);

      // Retrieve the token and fetch the user profile data if needed
      String? token = await provider.getTokenFromStorage();
      if (token != null && provider.profileModel == null) {
        // Fetch user profile if not already loaded
        await provider.fetchUserProfile();
        await provider.fetchSystemStatus();
      } else {
        print("No token found. Please log in.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.lightBlue50,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Monitoring Header Section
              Container(
                height: 350.h,
                width: double.infinity,
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

              // User Profile Section
              _buildUserProfileSection(profileProvider),

              // System Status Section
              _buildSystemStatusSection(profileProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfileSection(ProfileProvider profileProvider) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.h),
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 28.h),
      decoration: BoxDecoration(
        color: appTheme.blue200,
        borderRadius: BorderRadiusStyle.roundedBorderl4,
      ),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (profileProvider.base64Image != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(28.h),
              child: Image.memory(
                profileProvider.base64Image!,
                height: 60.h,
                width: 56.h,
                fit: BoxFit.cover,
              ),
            )
          else if (profileProvider.imagePath != null &&
              profileProvider.imagePath!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(28.h),
              child: Image.network(
                profileProvider.imagePath!,
                height: 60.h,
                width: 56.h,
                fit: BoxFit.cover,
              ),
            )
          else
            CustomImageView(
              imagePath: ImageConstant.imgProfil,
              height: 60.h,
              width: 56.h,
              radius: BorderRadius.circular(28.h),
              alignment: Alignment.center,
            ),
          SizedBox(width: 10.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profileProvider.profileModel?.username?.isNotEmpty == true
                      ? profileProvider.profileModel!.username!
                      : "SMT Utilisateur",
                  style: CustomTextStyle.titleLargeOnPrimaryBold,
                ),
                SizedBox(height: 10.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Department: ",
                        style:
                            CustomTextStyle.labelLargePoppinsOnPrimarySemi8old,
                      ),
                      TextSpan(
                        text: profileProvider
                                    .profileModel?.department?.isNotEmpty ==
                                true
                            ? profileProvider.profileModel!.department!
                            : "SMT ",
                        style: CustomTextStyle.bodyMediumPoppinsOnPrimary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemStatusSection(ProfileProvider profileProvider) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.h, vertical: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 28.h),
      decoration: BoxDecoration(
        color: appTheme.blue200,
        borderRadius: BorderRadiusStyle.roundedBorderl4,
      ),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "État du système",
            style: CustomTextStyle.titleLargeOnPrimaryBold,
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Indicateur visuel (cercle rouge ou vert)
              Container(
                width: 12.0,
                height: 12.h,
                decoration: BoxDecoration(
                  color: profileProvider.systemStatusModel?.isStable == true
                      ? Colors.green // Vert si stable
                      : Colors.red, // Rouge si non stable
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                profileProvider.systemStatusModel?.systemStatus ??
                    "Chargement...",
                style: CustomTextStyle.bodyMediumPoppinsOnPrimary,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
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
