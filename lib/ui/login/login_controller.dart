import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_project/ui/data/storage_manager.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    var user = StorageManager().getLoggedInUser();
  }
}
