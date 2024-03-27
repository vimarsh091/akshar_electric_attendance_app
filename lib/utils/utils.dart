import 'package:get/get.dart';

class Utils{
  /// Show common snack bar messages
  static void showMessage(String title, String message, {snackPosition = SnackPosition.BOTTOM}) {
    Get.snackbar(title, message, snackPosition: snackPosition);
  }
}