import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_project/data/network/repository/user_auth_repository.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    usernameController.text = 'Vimars';
    passwordController.text = 'Password@123';
    //   var user = StorageManager().getLoggedInUser();
  }

  void login() {
    var param = {
      'username': 'abc user',
      'password': 'Test@123',
    };
    UserAuthRepository().loginUser(param).then((value) {
      value?.fold((left) => null, (right) => null);
    });
  }
}
