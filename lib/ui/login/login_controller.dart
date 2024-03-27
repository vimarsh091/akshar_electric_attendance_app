import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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
}
