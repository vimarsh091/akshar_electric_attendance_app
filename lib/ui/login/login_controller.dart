import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_project/app/app_route.dart';
import 'package:test_project/data/network/models/LoginResponse.dart';
import 'package:test_project/data/network/repository/repository.dart';
import 'package:test_project/generated/locales.g.dart';
import 'package:test_project/ui/data/storage_manager.dart';
import 'package:test_project/utils/utils.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    usernameController.text = 'admin@admin.com';
    passwordController.text = 'Admin@123';
    //   var user = StorageManager().getLoggedInUser();
  }

  Future<void> login() async {
    isLoading.value = true;
    var param = {
      'email': usernameController.text.trim(),
      'password': passwordController.text.trim(),
    };
    Repository().loginUser(param).then((value) {
      value?.fold((left) {
        isLoading.value = false;
        Utils.showMessage(LocaleKeys.error.tr, left);
      }, (right) async {
        LoginResponse user = right;

        StorageManager().setAuthToken(user.data?.token ?? '');
        StorageManager().setLoggedInUser(user);
        if (user.data?.user?.isAdmin == true) {
          Get.offAndToNamed(AppRoutes.adminHomePage);
        } else {
          Get.offAndToNamed(AppRoutes.employeeHomePage);
        }
      });
    });
  }
}
