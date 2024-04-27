import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_project/app/app_color.dart';
import 'package:test_project/data/network/models/get_me_response.dart';
import 'package:test_project/data/network/models/site_status_response.dart'
    as site;
import 'package:test_project/data/network/repository/repository.dart';
import 'package:test_project/gen/assets.gen.dart';
import 'package:test_project/generated/locales.g.dart';
import 'package:test_project/ui/widgets/common_app_image.dart';
import 'package:test_project/utils/utils.dart';

class EmployeeHomeController extends GetxController {
  TextEditingController siteNameController = TextEditingController();
  RxBool isLoading = false.obs;
  RxString imageValue = Assets.images.aksharLogo.path.obs;
  RxString actionBtnText = LocaleKeys.checkIn.tr.obs;
  DateTime _lastLoginTime = DateTime(
      DateTime.now().year - 1,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second);
  Timer? _timer;
  Rx<Duration> elapsedTime = Duration.zero.obs;
  Rxn<GetMeResponse> getMeData = Rxn<GetMeResponse>();

  Rxn<site.Data> siteStatusData = Rxn<site.Data>();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getMe();
      getSiteStatus();
    });
  }

  void _calculateElapsedTime() {
    DateTime currentTime = DateTime.now();
    elapsedTime.value = currentTime.difference(_lastLoginTime);
  }

  Future<void> _initPreferences(DateTime time) async {
    _lastLoginTime = time ??
        DateTime(
            DateTime.now().year - 1,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour,
            DateTime.now().minute,
            DateTime.now().second);
    _calculateElapsedTime();
  }

  void _startTimer() {
    DateTime currentDate = DateTime.now();
    if (_lastLoginTime.year == currentDate.year &&
        _lastLoginTime.month == currentDate.month) {
      elapsedTime.value = currentDate.difference(_lastLoginTime);
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        elapsedTime.value = elapsedTime.value + const Duration(seconds: 1);
      });
    } else {
      debugPrint('else part');
    }
  }

  void getMe() async {
    isLoading.value = true;
    Repository().getMe().then((value) {
      isLoading.value = false;
      value?.fold((left) => Utils.showMessage(LocaleKeys.error.tr, left),
          (right) async {
        getMeData.value = right;
      });
    });
  }

  void getSiteStatus() async {
    isLoading.value = true;
    Repository().getSiteStatus().then((value) {
      isLoading.value = false;
      value?.fold((left) => Utils.showMessage(LocaleKeys.error.tr, left),
          (right) async {
        siteStatusData.value = right.data;
        siteNameController.text = right.data?.status?.siteName ?? '';
        actionBtnText.value = right.data?.action == 'check-out'
            ? LocaleKeys.checkOut.tr
            : LocaleKeys.checkIn.tr;
        if (right.data?.action == 'check-out') {
          _initPreferences(DateTime.parse(right.data?.status?.checkIn ?? ''));
          _startTimer();
        }
      });
    });
  }

  void checkInUser(File image) async {
    isLoading.value = true;
    Repository()
        .checkIn(siteName: siteNameController.text.trim(), image: image)
        .then((value) {
      isLoading.value = false;
      value?.fold((left) => Utils.showMessage(LocaleKeys.error.tr, left),
          (right) async {
        actionBtnText.value = LocaleKeys.checkOut.tr;
        _initPreferences(DateTime.parse(right.data?.checkIn ?? ''));
        _startTimer();
      });
    });
  }

  void checkOut() async {
    isLoading.value = true;
    Repository().checkOut().then((value) {
      isLoading.value = false;
      value?.fold((left) => Utils.showMessage(LocaleKeys.error.tr, left),
          (right) async {
        _timer?.cancel();
        showCompleteDialog(
            message: 'Your time is successfully saved',
            onclick: () {
              SystemNavigator.pop();
            },
            icon: Assets.images.icSuccess);
      });
    });
  }

  void showCompleteDialog(
      {String? icon, String? message, required VoidCallback onclick}) {
    Get.dialog(
        barrierDismissible: false,
        Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                10.verticalSpace,
                CommonAppImage(imagePath: icon ?? '', height: 88, width: 88),
                20.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Text(
                      message ?? '',
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                26.verticalSpace,
                GestureDetector(
                  onTap: () {
                    onclick.call();
                  },
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.colorAppTheme),
                    child: const Text(
                      textAlign: TextAlign.center,
                      'Okay',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }
}
