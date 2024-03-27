import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_project/app/app_color.dart';
import 'package:test_project/gen/assets.gen.dart';
import 'package:test_project/ui/data/storage_manager.dart';
import 'package:test_project/ui/employee/employee_home_controller.dart';
import 'package:test_project/ui/widgets/common_app_bar.dart';
import 'package:test_project/ui/widgets/common_app_image.dart';
import 'package:test_project/utils/utils.dart';

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
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                          side: BorderSide(color: AppColors.colorAppTheme)),
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
                              CommonAppImage(
                                path: Assets.images.aksharLogo.path,
                                height: 90.w,
                                width: 90.w,
                                radius: 50,
                                fit: BoxFit.cover,
                              ),
                              /* Image.file(controller.imageValue.value);*/
                              20.verticalSpace,
                              Text(
                                'Welcome user name',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              20.verticalSpace,
                              Obx(
                                () => Text(
                                  'Todaytracked time:- ${controller.elapsedTime.value.inHours}:${(controller.elapsedTime.value.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.elapsedTime.value.inSeconds % 60).toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              20.verticalSpace,
                              TextField(
                                controller: controller.siteNameController,
                                decoration: InputDecoration(
                                    hintText: 'Enter site name',
                                    labelText: 'Enter site name',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
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
                if (controller.siteNameController.text.trim().isEmpty) {
                  Utils.showMessage('Error', 'Please enter sitename');
                } else {
                  final ImagePicker picker = ImagePicker();

                  final XFile? photo =
                      await picker.pickImage(source: ImageSource.camera);

                  if (photo != null) {
                    controller.imageValue.value = photo.path;
                    StorageManager()
                        .setPunchInTime(DateTime.timestamp().toString());
                  } else {
                    Utils.showMessage('Error', 'Something went wrong');
                  }
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
                  'Punch In',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            20.verticalSpace
          ],
        ),
      ),
    );
  }
}
