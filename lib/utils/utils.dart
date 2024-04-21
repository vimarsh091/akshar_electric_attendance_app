import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:test_project/app/app_color.dart';
import 'package:test_project/generated/locales.g.dart';

class Utils {
  static String ddmmyyyyFormat = 'dd-MM-yyyy';
  static String yyyymmddFormat = 'yyyy-MM-dd';

  /// Show common snack bar messages
  static void showMessage(String title, String message,
      {snackPosition = SnackPosition.TOP}) {
    Get.snackbar(title, message,
        snackPosition: snackPosition,
        backgroundColor: AppColors.colorAppTheme.withAlpha(80));
  }

  /// Show popup dialog with title and message
  static void showPopupDialog(String title, String message,
      {bool isDismissible = false,
      String? textConfirm,
      Future<bool> Function()? onWillPop,
      VoidCallback? onConfirm,
      Color? confirmTextColor}) {
    Get.defaultDialog(
        title: title,
        middleText: message,
        barrierDismissible: isDismissible,
        textConfirm: textConfirm,
        onWillPop: onWillPop,
        onConfirm: onConfirm,
        confirmTextColor: confirmTextColor);
  }

  /// Select image from camera or gallery
  static void showImagePickerBottomSheet(
      Function(String? imagePath) onImagePicked) {
    Get.bottomSheet(
      Wrap(
        children: [
          ListTile(
            title: Text(
              LocaleKeys.selectImageFrom.tr,
              style: TextStyle(
                  fontSize: 14,
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w700),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.camera_alt,
              size: 24,
              color: AppColors.colorWhite,
            ),
            title: Text(
              LocaleKeys.camera.tr,
              style: TextStyle(
                  fontSize: 14,
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w700),
            ),
            onTap: () async {
              Get.back();
              final XFile? image =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              onImagePicked.call(image?.path);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.image,
              size: 24,
              color: AppColors.colorWhite,
            ),
            title: Text(
              LocaleKeys.gallery.tr,
              style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w700),
            ),
            onTap: () async {
              Get.back();
              final XFile? image =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              onImagePicked.call(image?.path);
            },
          )
        ],
      ),
      barrierColor: AppColors.colorBlack.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: AppColors.colorAppTheme,
      enableDrag: false,
    );
  }

  static Widget commonProgressIndicator({double? topPadding}) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: topPadding ?? 0.0),
        child: LoadingAnimationWidget.threeArchedCircle(
          color: AppColors.colorAppTheme,
          size: 50,
        ),
      ),
    );
  }

  static String getFormattedDate(String date, String outputFormat) {
    DateTime inputDate = DateTime.parse(date);

    return DateFormat(outputFormat).format(inputDate);
  }

  static String convertTo12HourFormat(String time24) {
    if (time24.isEmpty) {
      return 'N/A';
    }
    // Parse the time string to a DateTime object
    DateTime time = DateFormat('HH:mm:ss').parse(time24);

    // Format the DateTime object in 12-hour format
    String time12 = DateFormat('h:mm a').format(time);

    return time12;
  }
}
