import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_project/app/app_color.dart';
import 'package:test_project/gen/assets.gen.dart';
import 'package:test_project/ui/add_employee/add_employee_controller.dart';
import 'package:test_project/ui/widgets/common_app_bar.dart';
import 'package:test_project/ui/widgets/common_app_image.dart';

import '../../utils/utils.dart';

class AddEmployeePage extends GetView<AddEmployeeController> {
  const AddEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 36.h),
        child: CommonAppBar(
            showLeading: true,
            onLeadingTap: () {
              Get.back();
            },
            title: 'Add Employee Profile'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    30.verticalSpace,
                    Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.w),
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: AppColors.colorAppTheme)),
                        child: Obx(
                          () => CommonAppImage(
                            imagePath: controller.profilePhoto.value,
                            height: 140.w,
                            width: 140.w,
                            radius: 100.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 20.w,
                          right: 0,
                          child: GestureDetector(
                            onTap: () =>
                                Utils.showImagePickerBottomSheet((imagePath) {
                                  if (imagePath != null) {
                                    controller.profilePhoto.value = imagePath;
                                  }
                                }),
                            child: Container(
                              height: 26.w,
                              width: 26.w,
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1.5,
                                      color: AppColors.colorAppTheme)),
                              child: Icon(
                                size: 16.w,
                                Icons.edit,
                                color: AppColors.colorAppTheme,
                              ),
                            ),
                          )),
                      20.verticalSpace
                    ]),
                    40.verticalSpace,
                    TextField(
                      controller: controller.firstNameController,
                      decoration: InputDecoration(
                          hintText: 'Enter first name',
                          labelText: 'Enter first name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    20.verticalSpace,
                    TextField(
                      controller: controller.lastNameController,
                      decoration: InputDecoration(
                          hintText: 'Enter last name',
                          labelText: 'Enter last name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    20.verticalSpace,
                    TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      controller: controller.mobileNumberController,
                      decoration: InputDecoration(
                          hintText: 'Enter mobile number',
                          labelText: 'Enter mobile number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (controller.firstNameController.text.trim().isEmpty) {
                  Utils.showMessage('Error', 'Please enter first name');
                } else if (controller.lastNameController.text.trim().isEmpty) {
                  Utils.showMessage('Error', 'Please enter last name');
                } else if (controller.mobileNumberController.text
                    .trim()
                    .isEmpty) {
                  Utils.showMessage('Error', 'Please enter mobile number');
                } else if (controller.mobileNumberController.text
                        .trim()
                        .length !=
                    10) {
                  Utils.showMessage(
                      'Error', 'Please enter valid mobile number');
                } else if (controller.profilePhoto.value ==
                    Assets.images.icAvatar) {
                  Utils.showMessage('Error', 'Please select profile photo');
                } else {
                  controller.addUser();
                }
              },
              child: Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.colorAppTheme),
                child: Text(
                  textAlign: TextAlign.center,
                  'Add Employee Profile',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
