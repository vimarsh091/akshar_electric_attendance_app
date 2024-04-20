import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_project/data/network/client/api_client.dart';
import 'package:test_project/data/network/models/app_data_model.dart';
import 'package:test_project/data/network/repository/repository.dart';
import 'package:test_project/gen/assets.gen.dart';
import 'package:test_project/generated/locales.g.dart';
import 'package:test_project/utils/utils.dart';

class AddEmployeeController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  RxBool isLoading = false.obs;
  RxString profilePhoto = Assets.images.icAvatar.path.obs;
  AppDataModel appDataModel = AppDataModel();
  RxBool isEditProfile = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      appDataModel = Get.arguments as AppDataModel;
      isEditProfile.value = appDataModel.isEditProfile;
      getUserDetails();
    }
  }

  void getUserDetails() {
    isLoading.value = true;
    Repository().getUserDetails(id: appDataModel.userId).then((value) {
      isLoading.value = false;
      value?.fold((left) => Utils.showMessage(LocaleKeys.alert.tr, left),
          (right) {
        var result = right;
        profilePhoto.value = result.data?.avatar != null
            ? '${ApiClient.apiBaseUrl}${result.data?.avatar}'
            : Assets.images.icAvatar.path;
        firstNameController.text = result.data?.firstName ?? '';
        lastNameController.text = result.data?.lastName ?? '';
        mobileNumberController.text =
            result.data?.phone?.replaceFirst('+91', '') ?? '';
      });
    });
  }

  void addUser() {
    isLoading.value = true;
    Repository()
        .addUser(
      firstName: firstNameController.text.trim(),
      image: File(profilePhoto.value),
      lastName: lastNameController.text.trim(),
      mobileNumber: '+91${mobileNumberController.text.trim()}',
    )
        .then((value) {
      isLoading.value = false;
      value?.fold((left) => Utils.showMessage(LocaleKeys.error.tr, left),
          (right) {
        Get.back(result: true);
        Utils.showMessage(LocaleKeys.success.tr, right.message ?? '');
      });
    });
  }

  void updateUser() {
    isLoading.value = true;
    Repository()
        .updateUserDetails(
      id: appDataModel.userId,
      firstName: firstNameController.text.trim(),
      image: !profilePhoto.value.startsWith('http')
          ? File(profilePhoto.value)
          : null,
      lastName: lastNameController.text.trim(),
      mobileNumber: '+91${mobileNumberController.text.trim()}',
    )
        .then((value) {
      isLoading.value = false;
      value?.fold((left) => Utils.showMessage(LocaleKeys.error.tr, left),
          (right) {
        Get.back(result: true);
        Utils.showMessage(LocaleKeys.success.tr, right.message ?? '');
      });
    });
  }
}
