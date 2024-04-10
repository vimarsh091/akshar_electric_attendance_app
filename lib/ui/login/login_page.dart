import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_project/app/app_color.dart';
import 'package:test_project/ui/login/login_controller.dart';
import 'package:test_project/ui/widgets/common_app_image.dart';
import 'package:test_project/utils/utils.dart';

import '../../gen/assets.gen.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonAppImage(
                          imagePath: Assets.images.icLogin,
                          height: 150.h,
                          width: 150.h),
                      30.verticalSpace,
                      TextField(
                        controller: controller.usernameController,
                        decoration: InputDecoration(
                            hintText: 'Enter username',
                            labelText: 'Enter username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: AppColors.colorAppTheme))),
                      ),
                      20.verticalSpace,
                      TextField(
                        controller: controller.passwordController,
                        decoration: InputDecoration(
                            hintText: 'Enter password',
                            labelText: 'Enter password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: AppColors.colorAppTheme))),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (controller.usernameController.text.trim().isEmpty) {
                  Utils.showMessage('Error', 'Please enter username');
                } else if (controller.passwordController.text.trim().isEmpty) {
                  Utils.showMessage('Error', 'Please enter password');
                } else {
                  controller.login();
                }
              },
              child: Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.colorAppTheme),
                child: const Text(
                  textAlign: TextAlign.center,
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
