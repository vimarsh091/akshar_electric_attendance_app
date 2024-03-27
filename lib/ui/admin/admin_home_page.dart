import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_project/app/app_color.dart';
import 'package:test_project/app/app_route.dart';
import 'package:test_project/ui/admin/admin_home_controller.dart';
import 'package:test_project/ui/widgets/common_app_bar.dart';

class AdminHomePage extends GetView<AdminHomeController> {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 36.h),
        child: CommonAppBar(
            showLeading: true,
            leadingIcon: Icons.person_add_alt_1_outlined,
            onLeadingTap: () {
              Get.toNamed(AppRoutes.addEmployeePage);
            },
            title: 'Home'),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 20.w),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.employeeDetailsPage);
              },
              child: Card(
                elevation: 3,
                shadowColor: AppColors.colorAppTheme,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side:
                        BorderSide(color: AppColors.colorAppTheme, width: 0.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 8.h, bottom: 8.h, left: 12.w),
                      child: Text(
                        'Prashant Rudani',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 8.h, bottom: 8.h, right: 12.w),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.colorAppTheme,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }
}
