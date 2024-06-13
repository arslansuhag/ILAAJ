import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:illaj_app/controllers/profile-controller.dart';
import 'package:illaj_app/res/assets/images.dart';
import 'package:illaj_app/res/colors/app-colors.dart';
import 'package:illaj_app/res/components/custom-text-field-widget.dart';
import 'package:illaj_app/res/components/drawer-widget.dart';
import 'package:illaj_app/res/components/round-button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        } else {}
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const DrawerWidget(),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
                // Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Profile',
            style: TextStyle(fontSize: 17.sp),
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: EdgeInsets.all(20.r),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Obx(
                      () => Center(
                        child: profileController.uploadedImageURL.isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    profileController.uploadedImageURL),
                                radius: 60.r,
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    const AssetImage(ImageAssets.deafultUser),
                                backgroundColor: Colors.white,
                                radius: 60.r,
                              ),
                      ),
                    ),
                    Positioned(
                      right: 100.w,
                      bottom: 0,
                      child: Container(
                        height: 30.h,
                        decoration: BoxDecoration(
                            color: AppColors.greenColor.withOpacity(0.77),
                            shape: BoxShape.circle),
                        child: IconButton(
                            onPressed: profileController.pickImage,
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 20,
                            )),
                      ),
                    )
                  ],
                ),
                20.verticalSpace,
                Obx(
                  () => CustomTextFieldWidget(
                      // readOnly: true,
                      controller: profileController.nameController.value,
                      hintText: 'Name',
                      filled: true,
                      filledColor: const Color(0xffFFFFFF)),
                ),
                10.verticalSpace,
                Obx(
                  () => CustomTextFieldWidget(
                      readOnly: true,
                      controller: profileController.emailController.value,
                      hintText: 'Email',
                      filled: true,
                      filledColor: const Color(0xffFFFFFF)),
                ),
                10.verticalSpace,
                Obx(
                  () => CustomTextFieldWidget(
                      // readOnly: true,
                      controller: profileController.phoneController.value,
                      hintText: 'Phone',
                      filled: true,
                      filledColor: const Color(0xffFFFFFF)),
                ),
                10.verticalSpace,
                Obx(
                  () => CustomTextFieldWidget(
                      // readOnly: true,
                      controller: profileController.locationController.value,
                      hintText: 'Location',
                      filled: true,
                      filledColor: const Color(0xffFFFFFF)),
                ),
                30.verticalSpace,
                RoundButton(
                    buttonColor: AppColors.greenColor,
                    width: double.infinity,
                    title: 'Update',
                    onPressed: () async {
                      await profileController.updateProfile();
                      // Get.off(() => const BottomNavBarScreen());
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
