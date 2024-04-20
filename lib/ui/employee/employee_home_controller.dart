import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_project/data/network/models/get_me_response.dart';
import 'package:test_project/data/network/models/site_status_response.dart'
    as site;
import 'package:test_project/data/network/repository/repository.dart';
import 'package:test_project/gen/assets.gen.dart';
import 'package:test_project/generated/locales.g.dart';
import 'package:test_project/utils/utils.dart';

class EmployeeHomeController extends GetxController {
  TextEditingController siteNameController = TextEditingController();
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
        _lastLoginTime.month == currentDate.month &&
        _lastLoginTime.day == currentDate.day) {
      elapsedTime.value = currentDate.difference(_lastLoginTime);
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        elapsedTime.value = elapsedTime.value + const Duration(seconds: 1);
      });
    }
  }

  void getMe() async {
    Repository().getMe().then((value) {
      value?.fold((left) => Utils.showMessage(LocaleKeys.error.tr, left),
          (right) async {
        getMeData.value = right;
      });
    });
  }

  void getSiteStatus() async {
    Repository().getSiteStatus().then((value) {
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
    Repository()
        .checkIn(siteName: siteNameController.text.trim(), image: image)
        .then((value) {
      value?.fold((left) => Utils.showMessage(LocaleKeys.error.tr, left),
          (right) async {
        _initPreferences(DateTime.parse(right.data?.checkIn ?? ''));
        _startTimer();
      });
    });
  }

  void checkOut() async {
    Repository().checkOut().then((value) {
      value?.fold((left) => Utils.showMessage(LocaleKeys.error.tr, left),
          (right) async {
        _timer?.cancel();
      });
    });
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }
}
