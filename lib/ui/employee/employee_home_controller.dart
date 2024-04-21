import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:test_project/data/network/models/get_me_response.dart';
import 'package:test_project/data/network/models/site_status_response.dart'
    as site;
import 'package:test_project/data/network/repository/repository.dart';
import 'package:test_project/gen/assets.gen.dart';
import 'package:test_project/generated/locales.g.dart';
import 'package:test_project/utils/utils.dart';

import '../../app/app_color.dart';

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
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
        showCompleteDialog(right.data?.totalTime ?? '');
      });
    });
  }



  void showCompleteDialog(String totalTime) {
    Dialogs.materialDialog(
        color: Colors.white,
        msg: totalTime,
        barrierDismissible: false,
        title: 'Congratulations, your time was saved',
        lottieBuilder: Lottie.asset(
          Assets.lottie.information,
          fit: BoxFit.fill,
        ),
        customViewPosition: CustomViewPosition.BEFORE_ACTION,
        context: Get.context!,
        actions: [
          IconsButton(
            onPressed: () {
              Get.back();
              //Future.delayed(Duration(milliseconds: 100));
              Get.back();
            },
            text: 'Done',
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: AppColors.colorAppTheme,
            textStyle: const TextStyle(color: Colors.white),
          ),
        ]);
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }
}
