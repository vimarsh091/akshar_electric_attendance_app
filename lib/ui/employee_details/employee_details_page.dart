import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:test_project/app/app_color.dart';
import 'package:test_project/data/network/client/api_client.dart';
import 'package:test_project/data/network/models/user_sites_response.dart';
import 'package:test_project/gen/assets.gen.dart';
import 'package:test_project/ui/employee_details/employee_details_controller.dart';
import 'package:test_project/ui/widgets/common_app_bar.dart';
import 'package:test_project/ui/widgets/common_app_image.dart';
import 'package:test_project/utils/extentions.dart';
import 'package:test_project/utils/utils.dart';

class EmployeeDetailsPage extends GetView<EmployeeDetailsController> {
  const EmployeeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back(result: true);
        return Future(() => true);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 36.h),
          child: CommonAppBar(
            showLeading: true,
            onLeadingTap: () {
              Get.back(result: true);
            },
            popupKey: controller.popUpKey,
            title: 'Employee profile',
            onSufixTap: () {
              PopupMenu(
                      context: context,
                      config: MenuConfig.forList(
                          backgroundColor: AppColors.colorAppTheme,
                          arrowHeight: 16,
                          itemWidth: 120.w,
                          lineColor: Colors.red),
                      items: [
                        MenuItem.forList(
                            textStyle: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            title: 'Edit Profile',
                            image: const Icon(Icons.mode_edit_rounded,
                                color: Colors.white, size: 20)),
                        MenuItem.forList(
                            textStyle: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            title: 'Call Now',
                            image: const Icon(Icons.call_rounded,
                                color: Colors.white, size: 20)),
                        MenuItem.forList(
                            textStyle: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            title: 'Share Password',
                            image: const Icon(Icons.password_rounded,
                                color: Colors.white, size: 20)),
                        MenuItem.forList(
                            textStyle: const TextStyle(
                                color: Colors.red, fontSize: 12),
                            title: 'Delete Profile',
                            image: const Icon(Icons.delete_rounded,
                                color: Colors.red, size: 20)),
                      ],
                      onClickMenu: controller.onClickMenu,
                      onShow: controller.onShow,
                      onDismiss: controller.onDismiss)
                  .show(widgetKey: controller.popUpKey);
            },
            showSufixIcon: true,
          ),
        ),
        backgroundColor: Colors.white,
        body: Obx(
          () => controller.isLoading.isTrue
              ? Utils.commonProgressIndicator()
              : SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  controller: controller.scrollController,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          26.verticalSpace,
                          CommonAppImage(
                            imagePath: controller
                                        .userDetails.value?.data?.avatar !=
                                    null
                                ? '${ApiClient.apiBaseUrl}${controller.userDetails.value?.data?.avatar ?? ''}'
                                : Assets.images.icAvatar.path,
                            height: 120.w,
                            width: 120.w,
                            fit: BoxFit.cover,
                            radius: 100,
                          ),
                          12.verticalSpace,
                          Text(
                            '${controller.userDetails.value?.data?.firstName ?? ''} ${controller.userDetails.value?.data?.lastName ?? ''}',
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                          12.verticalSpace,
                          Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () => Text(
                                    controller.selectedDateRangeText.value,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ).onTap(() {
                              _showDatePicker(Get.context!);
                            }),
                          ),
                          Obx(
                            () => Text(
                              controller.totalWorkingHours.value,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                          ),
                          20.verticalSpace,
                          Obx(
                            () => ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.siteList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var item = controller.siteList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Slidable(
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
                                                controller.slidableController
                                                    .close();
                                                showEditDetailsSheet(item);
                                              },
                                              backgroundColor:
                                                  AppColors.colorAppTheme,
                                              foregroundColor: Colors.white,
                                              icon: Icons.edit,
                                              label: 'Edit',
                                              autoClose: true,
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                            ),
                                          ],
                                        ),

                                        // The child of the Slidable is what the user sees when the
                                        // component is not dragged.
                                        child: Card(
                                          elevation: 3,
                                          shadowColor: AppColors.colorAppTheme,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              side: const BorderSide(
                                                  color:
                                                      AppColors.colorAppTheme,
                                                  width: 0.5)),
                                          child: Padding(
                                            padding: EdgeInsets.all(12.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          'Date :- ${item.date}'),
                                                      4.verticalSpace,
                                                      Text(
                                                          'Site name :- ${item.siteName}'),
                                                      4.verticalSpace,
                                                      Text(
                                                          'Check in :- ${Utils.convertTo12HourFormat(item.checkIn ?? '')}'),
                                                      4.verticalSpace,
                                                      Text(
                                                          'Check out :- ${Utils.convertTo12HourFormat(item.checkOut ?? '')}'),
                                                      4.verticalSpace,
                                                      Text(
                                                          'Total time :- ${item.totalTime}'),
                                                    ],
                                                  ),
                                                ),
                                                12.horizontalSpace,
                                                CommonAppImage(
                                                  imagePath:
                                                      '${ApiClient.apiBaseUrl}${item.siteImage}',
                                                  height: 95.w,
                                                  width: 95.w,
                                                  radius: 22,
                                                  fit: BoxFit.cover,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (index ==
                                              controller.siteList.length - 1 &&
                                          controller.isAbleToLoadMore.isTrue)
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12.h),
                                          child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: Obx(() => controller
                                                    .isLoadingMore.isTrue
                                                ? const CircularProgressIndicator(
                                                    color:
                                                        AppColors.colorAppTheme,
                                                  )
                                                : Offstage()),
                                          ),
                                        )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Future showEditDetailsSheet(Data item) {
    controller.punchInController.text =
        Utils.convertTo12HourFormat(item.checkIn ?? '');
    controller.punchOutController.text =
        Utils.convertTo12HourFormat(item.checkOut ?? '');
    controller.siteNameController.text = item.siteName ?? '';
    return Get.bottomSheet(
        enableDrag: true,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: const BorderSide(color: AppColors.colorAppTheme, width: 2)),
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              12.verticalSpace,
              const Text(
                'Edit Details',
                style: TextStyle(
                    color: AppColors.colorAppTheme,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              20.verticalSpace,
              GestureDetector(
                onTap: () async {
                  var punchInTime = await showTimePicker(
                    context: Get.context!,
                    initialTime: TimeOfDay.now(),
                  );

                  if (punchInTime != null) {
                    controller.punchInController.text =
                        punchInTime.format(Get.context!);
                  }
                },
                child: TextField(
                  enabled: false,
                  controller: controller.punchInController,
                  decoration: InputDecoration(
                      hintText: 'Enter punch in time',
                      labelText: 'Enter punch in time',
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: AppColors.colorAppTheme)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: AppColors.colorAppTheme))),
                ),
              ),
              20.verticalSpace,
              GestureDetector(
                onTap: () async {
                  var punchOutTime = await showTimePicker(
                    context: Get.context!,
                    initialTime: TimeOfDay.now(),
                  );

                  if (punchOutTime != null) {
                    controller.punchOutController.text =
                        punchOutTime.format(Get.context!);
                  }
                },
                child: TextField(
                  enabled: false,
                  controller: controller.punchOutController,
                  decoration: InputDecoration(
                      hintText: 'Enter punch out time',
                      labelText: 'Enter punch out time',
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: AppColors.colorAppTheme)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: AppColors.colorAppTheme))),
                ),
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
                            const BorderSide(color: AppColors.colorAppTheme))),
              ),
              40.verticalSpace,
              GestureDetector(
                onTap: () {
                  var punchIn = DateFormat('hh:mm a')
                      .parse(controller.punchInController.text.trim());
                  var punchOut = DateFormat('hh:mm a')
                      .parse(controller.punchOutController.text.trim());

                  if (controller.punchInController.text.trim().isEmpty) {
                    Utils.showMessage('Error', 'Please enter punch in time');
                  } else if (controller.punchOutController.text
                      .trim()
                      .isEmpty) {
                    Utils.showMessage('Error', 'Please enter punch out time');
                  } else if (punchOut.isBefore(punchIn)) {
                    Utils.showMessage('Error',
                        'Punch out time should be after punch in time.');
                  } else if (controller.siteNameController.text
                      .trim()
                      .isEmpty) {
                    Utils.showMessage('Error', 'Please enter site name');
                  } else {
                    controller.updateSiteData(
                        siteName: controller.siteNameController.text.trim(),
                        siteId: item.id,
                        punchOutTime: DateFormat('HH:mm:ss').format(punchIn),
                        punchInTime: DateFormat('HH:mm:ss').format(punchOut));
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

  /// Show calendar in pop up dialog for selecting date range for calendar event.
  void _showDatePicker(BuildContext context) {
    showCustomDateRangePicker(
      context,
      dismissible: true,
      minimumDate: DateTime.now().subtract(const Duration(days: 1000)),
      maximumDate: DateTime.now(),
      endDate: DateTime.now(),
      backgroundColor: Colors.white,
      primaryColor: AppColors.colorAppTheme,
      onApplyClick: (start, end) {
        controller.startTime =
            Utils.getFormattedDate(start.toString(), Utils.yyyymmddFormat);
        controller.endTime =
            Utils.getFormattedDate(end.toString(), Utils.yyyymmddFormat);
        controller.selectedDateRangeText.value =
            '${Utils.getFormattedDate(start.toString(), Utils.ddmmyyyyFormat)} to ${Utils.getFormattedDate(end.toString(), Utils.ddmmyyyyFormat)}';
        controller.getTotalWorkingHours();
      },
      onCancelClick: () {},
    );
  }
}
