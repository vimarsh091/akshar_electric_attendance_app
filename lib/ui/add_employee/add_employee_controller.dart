import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_project/data/network/repository/repository.dart';
import 'package:test_project/gen/assets.gen.dart';
import 'package:test_project/generated/locales.g.dart';
import 'package:test_project/utils/utils.dart';

class AddEmployeeController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  RxString profilePhoto = Assets.images.icAvatar.path.obs;

  void addUser() {
    var param = {
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'email': 'test@gmail.com',
      'phone': '+91${mobileNumberController.text.trim()}',
    };
    Repository().addUser(param, File(profilePhoto.value)).then((value) {
      value?.fold((left) => Utils.showMessage(LocaleKeys.error.tr, left),
          (right) {
        Get.back(result: true);
        Utils.showMessage(LocaleKeys.success.tr, right.message ?? '');
      });
    });
  }
}
