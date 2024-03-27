import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_project/gen/assets.gen.dart';
import 'package:test_project/ui/data/storage_manager.dart';

class EmployeeHomeController extends GetxController {
  TextEditingController siteNameController = TextEditingController();
  RxString imageValue = Assets.images.aksharLogo.path.obs;
  DateTime _lastLoginTime = DateTime(
      DateTime.now().year - 1,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second);
  Timer? _timer;
  Rx<Duration> elapsedTime = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    _initPreferences();
    _startTimer();
  }

  void _calculateElapsedTime() {
    DateTime currentTime = DateTime.now();
    elapsedTime.value = currentTime.difference(_lastLoginTime);
  }

  Future<void> _initPreferences() async {
    _lastLoginTime =
        DateTime.tryParse(StorageManager().getPunchInTime() ?? '') ??
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
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        elapsedTime.value = elapsedTime.value + const Duration(seconds: 1);
      });
    }
  }
}
