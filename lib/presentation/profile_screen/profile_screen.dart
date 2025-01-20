import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smtmonitoring/core/utils/validation_functions.dart';
import 'package:smtmonitoring/presentation/api_service.dart';
import 'package:smtmonitoring/presentation/notification_service.dart';
import 'package:smtmonitoring/presentation/profile_screen/provider/profile_provider.dart';
import 'package:smtmonitoring/presentation/websocket_connection.dart';
import 'package:smtmonitoring/widgets/custom_switch.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_trailing_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(apiService: ApiService()),
      child: const ProfileScreen(),
    );
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  final WebSocketService webSocketService = WebSocketService();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Démarrez le service WebSocket
    webSocketService.connect();

    // Écoutez les notifications entrantes et déclenchez l'état de notification
    webSocketService.messages.listen((message) {
      webSocketService.hasNotification.value = true;
      // Affiche une notification locale avec le message reçu
      NotificationService.showNotification("Nouvelle Notification", message);
    });

    // Initialise et surveille les permissions de notification
    NotificationService.monitorNotificationPermissions();

    // Use Future.microtask to ensure the provider context is available before making the call
    Future.microtask(() async {
      final provider = Provider.of<ProfileProvider>(context, listen: false);

      // Retrieve the token and fetch the user profile data if needed
      String? token = await provider.getTokenFromStorage();
      if (token != null && provider.profileModel == null) {
        // Fetch user profile if not already loaded
        await provider.fetchUserProfile();
      } else {
        print("No token found. Please log in.");
      }
    });
  }

  @override
  void dispose() {
    // Déconnectez le WebSocket
    webSocketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: Container(
              height: 772.h,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 70.h),
                    decoration: AppDecoration.fillLightBlue.copyWith(
                      borderRadius: BorderRadiusStyle.customBorderTL50,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfileInfo(context),
                        _buildUsernameSection(context),
                        SizedBox(height: 28.h),
                        _buildPhoneSection(context),
                        SizedBox(height: 18.h),
                        _buildEmailSection(context),
                        SizedBox(height: 40.h),
                        _buildNotificationsSection(context),
                        SizedBox(height: 48.h)
                      ],
                    ),
                  ),
                  _buildProfileImageSection(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 37.h,
      /*leading: AppbarLeadingImage(
          imagePath: ImageConstant.imgArrowLeft,
          margin: EdgeInsets.only(
            left: 19.h,
            top: 18.h,
            bottom: 21.h,
          ),
          onTap: () {
            onTapArrowleftone(context);
          }),*/
      centerTitle: true,
      title: AppbarSubtitle(
        text: "lbl_mon_profile".tr,
      ),
      actions: [
        AppbarTrailingIconbutton(
          imagePath: ImageConstant.imgChat,
          margin: EdgeInsets.only(
            top: 15.h,
            right: 10.h,
          ),
          notificationNotifier: ValueNotifier(false),
        ),
        AppbarTrailingIconbutton(
          imagePath: ImageConstant.imgVector, // Icône par défaut
          imagePathNotification:
              ImageConstant.imgAlert, // Icône de notification
          margin: EdgeInsets.only(
            left: 11.h,
            top: 15.h,
            right: 30.h,
          ),
          notificationNotifier:
              webSocketService.hasNotification, // Gestion dynamique
          onTap: () {
            // Réinitialise l'état des notifications après clic
            webSocketService.resetNotificationState();
            onTapArrowleftone2(context);
          },
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildProfileInfo(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(
        context); // Assuming you use Provider for state management
    return SizedBox(
      width: double.maxFinite,
      child: Align(
        heightFactor: 1.h,
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.h),
          child: Column(
            children: [
              Text(
                (profileProvider.profileModel?.username?.isNotEmpty == true
                    ? profileProvider.profileModel!.username
                    : "SMT Utilisateur")!, // Ensure it's non-null
                style: CustomTextStyle.titleLargeOnPrimaryBold,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "lbl_id".tr,
                      style: CustomTextStyle.labelLargePoppinsOnPrimarySemi8old,
                    ),
                    TextSpan(
                      text: "lbl_25030024".tr,
                      style: CustomTextStyle.bodyMediumPoppinsOnPrimary,
                    )
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "msg_param_tres_du_compte".tr,
                  style: CustomTextStyle.titleLargeOnPrimary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildUsernameSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl_username".tr,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall,
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.only(right: 20.h),
            child: Selector<ProfileProvider, TextEditingController?>(
              selector: (context, provider) => provider.userNameController,
              builder: (context, userNameController, child) {
                return CustomTextFormField(
                  controller: userNameController,
                  hintText: "Enter your username",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.h,
                    vertical: 4.h,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPhoneSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: Text(
              "lbl_phone".tr,
              style: theme.textTheme.titleSmall,
            ),
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(right: 22.h),
            child: Selector<ProfileProvider, TextEditingController?>(
              selector: (context, provider) => provider.phoneController,
              builder: (context, phoneController, child) {
                return CustomTextFormField(
                  controller: phoneController,
                  hintText: "msg_216_555_5555_55".tr,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.h,
                    vertical: 4.h,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEmailSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: Text(
              "lbl_email_address".tr,
              style: theme.textTheme.titleSmall,
            ),
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(right: 22.h),
            child: Selector<ProfileProvider, TextEditingController?>(
              selector: (context, provider) => provider.emailController,
              builder: (context, emailController, child) {
                return CustomTextFormField(
                  controller: emailController,
                  hintText: "msg_example_example_com".tr,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.emailAddress,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.h,
                    vertical: 4.h,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !isValidEmail(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildNotificationsSection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.h),
          child: Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 134.h,
                      child: Text(
                        "msg_push_notifications".tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    Selector<ProfileProvider, bool>(
                      selector: (context, provider) =>
                          provider.isSelectedSwitch,
                      builder: (context, isSelectedSwitch, child) {
                        return CustomSwitch(
                          margin: EdgeInsets.only(right: 26, bottom: 4),
                          alignment: Alignment.bottomCenter,
                          value: isSelectedSwitch,
                          onChange: (value) {
                            context
                                .read<ProfileProvider>()
                                .changeSwitchBox(value);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 102.h),
              CustomElevatedButton(
                height: 34.h,
                width: 168.h,
                text: "lbl_update_profile".tr,
                buttonStyle: CustomButtonStyles.fillBleu,
                buttonTextStyle: theme.textTheme.titleSmall!,
                onPressed: () async {
                  final provider =
                      Provider.of<ProfileProvider>(context, listen: false);
                  try {
                    print('Submit button pressed');

                    // Simply update the user profile without needing to upload image again
                    await provider.updateUserProfile();
                  } catch (e) {
                    print('Error: $e');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildProfileImageSection(BuildContext context) {
    File? _imageFile;
    final profileProvider = Provider.of<ProfileProvider>(
        context); // Assuming you use Provider for state management

    // Pick an image from the gallery
    Future<void> _pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path); // Store the picked file
        });

        // Store the image file in the provider (only path is passed to the backend)
        final provider = Provider.of<ProfileProvider>(context, listen: false);
        provider
            .setImageFile(_imageFile); // Store the image file in the provider
      }
    }

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 118.h,
        margin: EdgeInsets.only(top: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 136.h),
        child: Stack(
          alignment: Alignment.center,
          children: [
// Display the selected image or a default image if no image is selected
            if (profileProvider.base64Image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(56.h),
                child: Image.memory(
                  profileProvider.base64Image!,
                  height: 130.h,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              )
            else if (profileProvider.imageFile != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(56.h),
                child: Image.file(
                  profileProvider.imageFile!,
                  height: 130.h,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              )
            else if (profileProvider.imagePath != null &&
                profileProvider.imagePath!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(56.h),
                child: Image.network(
                  profileProvider.imagePath!,
                  height: 130.h,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              )
            else
              CustomImageView(
                imagePath: ImageConstant.imgProfil,
                height: 130.h,
                width: double.maxFinite,
                radius: BorderRadius.circular(56.h),
              ),
            Padding(
              padding: EdgeInsets.only(right: 8.h),
              child: CustomIconButton(
                height: 24.h,
                width: 24.h,
                padding: EdgeInsets.all(4.h),
                decoration: IconButtonStyleHelper.fillBlue,
                alignment: Alignment.bottomRight,
                onTap: _pickImage, // Call method to pick an image
                child: CustomImageView(
                  imagePath: ImageConstant.imgAdd, // icon to add image
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone(BuildContext context) {
    NavigatorService.goBack();
  }

  onTapArrowleftone1(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.barnavContainerScreen);
  }

  onTapArrowleftone2(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.notificationScreen);
  }
}
