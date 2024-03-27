import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:test_project/app/app_route.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<double> animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void onInit() {
    super.onInit();
    // Start the animation
    _controller.forward().whenComplete(() {
      // After the animation completes, stop the controller
      _controller.stop();
      Get.offAndToNamed(AppRoutes.loginPage);
    });
  }
}
