import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:test_project/app/app_color.dart';
import 'package:test_project/gen/assets.gen.dart';
import 'package:test_project/ui/employee_details/employee_details_controller.dart';
import 'package:test_project/ui/widgets/common_app_bar.dart';
import 'package:test_project/ui/widgets/common_app_image.dart';
import 'package:test_project/utils/utils.dart';

class EmployeeDetailsPage extends GetView<EmployeeDetailsController> {
  const EmployeeDetailsPage({super.key});

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
          title: 'Employee profile',
          onSufixTap: () {
            listMenu();
          },
          showSufixIcon: true,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              26.verticalSpace,
              GestureDetector(
                onTap: () => listMenu(),
                child: CommonAppImage(
                  path: Assets.images.icAvatar.path,
                  height: 120.w,
                  width: 120.w,
                  fit: BoxFit.contain,
                  radius: 100,
                ),
              ),
              12.verticalSpace,
              GestureDetector(
                onTap: () => controller.slidableController.close(),
                child: Text(
                  'Prashant Rudani',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
              ),
              20.verticalSpace,
              ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        openThreshold: 0.3,
                        closeThreshold: 0.3,
                        dragDismissible: true,
                        extentRatio: 0.3,
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              controller.slidableController.close();
                              showEditDetailsSheet();
                            },
                            backgroundColor: AppColors.colorAppTheme,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                            autoClose: true,
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: Card(
                        elevation: 3,
                        shadowColor: AppColors.colorAppTheme,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                                color: AppColors.colorAppTheme, width: 0.5)),
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Date :- 24-03-2024'),
                                    4.verticalSpace,
                                    Text('Date :- 24-03-2024'),
                                    4.verticalSpace,
                                    Text('Date :- 24-03-2024'),
                                    4.verticalSpace,
                                    Text('Date :- 24-03-2024'),
                                    4.verticalSpace,
                                    Text('Date :- 24-03-2024'),
                                  ],
                                ),
                              ),
                              12.horizontalSpace,
                              CommonAppImage(
                                path: Assets.images.icLogin,
                                height: 65.w,
                                width: 65.w,
                                radius: 22,
                                fit: BoxFit.contain,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future showEditDetailsSheet() {
    return Get.bottomSheet(
        enableDrag: true,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: BorderSide(color: AppColors.colorAppTheme, width: 2)),
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              12.verticalSpace,
              Text(
                'Edit Details',
                style: TextStyle(
                    color: AppColors.colorAppTheme,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              20.verticalSpace,
              TextField(
                controller: controller.punchInController,
                decoration: InputDecoration(
                    hintText: 'Enter punch in time',
                    labelText: 'Enter punch in time',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: AppColors.colorAppTheme))),
              ),
              20.verticalSpace,
              TextField(
                controller: controller.punchOutController,
                decoration: InputDecoration(
                    hintText: 'Enter punch out time',
                    labelText: 'Enter punch out time',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: AppColors.colorAppTheme))),
              ),
              20.verticalSpace,
              TextField(
                controller: controller.siteNameController,
                decoration: InputDecoration(
                    hintText: 'Enter site name',
                    labelText: 'Enter site name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: AppColors.colorAppTheme))),
              ),
              40.verticalSpace,
              GestureDetector(
                onTap: () {
                  if (controller.punchInController.text.trim().isEmpty) {
                    Utils.showMessage('Error', 'Please enter punch in time');
                  } else if (controller.punchOutController.text
                      .trim()
                      .isEmpty) {
                    Utils.showMessage('Error', 'Please enter punch out time');
                  } else if (controller.siteNameController.text
                      .trim()
                      .isEmpty) {
                    Utils.showMessage('Error', 'Please enter site name');
                  } else {
                    Get.back();
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
                    'Update',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
              20.verticalSpace
            ],
          ),
        ));
  }

  void listMenu() {
    PopupMenu menu = PopupMenu(
        context: Get.context!,
        config: MenuConfig.forList(),
        items: [
          // MenuItem.forList(
          //     title: 'Copy', image: Image.asset('assets/copy.png')),
          MenuItem.forList(
              title: 'Home',
              image: Icon(Icons.home, color: Color(0xFF181818), size: 20)),
          MenuItem.forList(
              title: 'Mail',
              image: Icon(Icons.mail, color: Color(0xFF181818), size: 20)),
          MenuItem.forList(
              title: 'Power',
              image: Icon(Icons.power, color: Color(0xFF181818), size: 20)),
          MenuItem.forList(
              title: 'Setting',
              image: Icon(Icons.settings, color: Color(0xFF181818), size: 20)),
          MenuItem.forList(
              title: 'PopupMenu',
              image: Icon(Icons.menu, color: Color(0xFF181818), size: 20))
        ],
        onClickMenu: controller.onClickMenu,
        onShow: controller.onShow,
        onDismiss: controller.onDismiss);
  }
}
