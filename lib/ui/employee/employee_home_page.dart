import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_project/app/app_color.dart';
import 'package:test_project/data/network/client/api_client.dart';
import 'package:test_project/generated/locales.g.dart';
import 'package:test_project/ui/employee/employee_home_controller.dart';
import 'package:test_project/ui/widgets/common_app_bar.dart';
import 'package:test_project/ui/widgets/common_app_image.dart';
import 'package:test_project/utils/utils.dart';

import '../../gen/assets.gen.dart';

class EmployeeHomePage extends GetView<EmployeeHomeController> {
  const EmployeeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size(Get.width, 56),
          child: CommonAppBar(
              onLeadingTap: () {}, showLeading: false, title: 'Home')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => controller.isLoading.isTrue
              ? Utils.commonProgressIndicator()
              : Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                  side: BorderSide(
                                      color: AppColors.colorAppTheme)),
                              clipBehavior: Clip.hardEdge,
                              elevation: 3,
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              shadowColor: AppColors.colorAppTheme,
                              child: Padding(
                                padding: EdgeInsets.all(16.w),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      20.verticalSpace,
                                      Obx(
                                        () => controller.getMeData.value?.data
                                                    ?.avatar !=
                                                null
                                            ? CommonAppImage(
                                                imagePath:
                                                    '${ApiClient.apiBaseUrl}${controller.getMeData.value?.data?.avatar}',
                                                height: 100.w,
                                                width: 100.w,
                                                radius: 50,
                                                fit: BoxFit.cover,
                                              )
                                            : Offstage(),
                                      ),
                                      /* Image.file(controller.imageValue.value);*/
                                      20.verticalSpace,
                                      Obx(
                                        () => Text(
                                          'Welcome ${controller.getMeData.value?.data?.firstName} ${controller.getMeData.value?.data?.lastName}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      60.verticalSpace,
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: AppColors.colorAppTheme
                                                    .withAlpha(40)),
                                            child: Padding(
                                              padding: EdgeInsets.all(18),
                                              child: Obx(
                                                () => Text(
                                                  '${controller.elapsedTime.value.inHours.toString().length == 1 ? '0${controller.elapsedTime.value.inHours}' : controller.elapsedTime.value.inHours}',
                                                  style: const TextStyle(
                                                      fontSize: 48,
                                                      color:
                                                          AppColors.colorBlack,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          ),
                                          4.horizontalSpace,
                                          const Text(
                                            ':',
                                            style: TextStyle(
                                                fontSize: 52,
                                                color: AppColors.colorBlack,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          4.horizontalSpace,
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: AppColors.colorAppTheme
                                                    .withAlpha(40)),
                                            child: Padding(
                                              padding: EdgeInsets.all(18),
                                              child: Obx(
                                                () => Text(
                                                  (controller.elapsedTime.value
                                                              .inMinutes %
                                                          60)
                                                      .toString()
                                                      .padLeft(2, '0'),
                                                  style: const TextStyle(
                                                      fontSize: 48,
                                                      color:
                                                          AppColors.colorBlack,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          ),
                                          4.horizontalSpace,
                                          const Text(
                                            ':',
                                            style: TextStyle(
                                                fontSize: 52,
                                                color: AppColors.colorBlack,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          4.horizontalSpace,
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: AppColors.colorAppTheme
                                                    .withAlpha(40)),
                                            child: Padding(
                                              padding: EdgeInsets.all(18),
                                              child: Obx(
                                                () => Text(
                                                  (controller.elapsedTime.value
                                                              .inSeconds %
                                                          60)
                                                      .toString()
                                                      .padLeft(2, '0'),
                                                  style: const TextStyle(
                                                      fontSize: 48,
                                                      color:
                                                          AppColors.colorBlack,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )

                                      /*   Obx(
                                  () => Text(
                                    'Todaytracked time:- ${controller.elapsedTime.value.inHours}:${(controller.elapsedTime.value.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.elapsedTime.value.inSeconds % 60).toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )*/
                                      ,
                                      60.verticalSpace,
                                      Obx(
                                        () => TextField(
                                          enabled:
                                              controller.actionBtnText.value ==
                                                      LocaleKeys.checkIn.tr
                                                  ? true
                                                  : false,
                                          controller:
                                              controller.siteNameController,
                                          decoration: InputDecoration(
                                              hintText: 'Enter site name',
                                              labelText: 'Enter site name',
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          30.verticalSpace
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (controller.actionBtnText.value ==
                            LocaleKeys.checkIn.tr) {
                          if (controller.siteNameController.text
                              .trim()
                              .isEmpty) {
                            Utils.showMessage('Error', 'Please enter sitename');
                          } else {
                            final ImagePicker picker = ImagePicker();

                            final XFile? photo = await picker.pickImage(
                                source: ImageSource.camera,imageQuality: 50);

                            if (photo != null) {
                              controller.imageValue.value = photo.path;
                              controller.checkInUser(File(photo.path));
                            } else {
                              Utils.showMessage(
                                  'Error', 'Something went wrong');
                            }
                          }
                        } else {
                          /// check out
                          controller.showCompleteDialog(
                              icon: Assets.images.icCaution,
                              message: 'Are you sure you want to checkout?',
                              onclick: () {
                                Get.back();
                                controller.checkOut();
                              });
                        }
                      },
                      child: Container(
                        width: Get.width,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.colorAppTheme),
                        child: Obx(
                          () => Text(
                            textAlign: TextAlign.center,
                            controller.actionBtnText.value,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    20.verticalSpace
                  ],
                ),
        ),
      ),
    );
  }
}
