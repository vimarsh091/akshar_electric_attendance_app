import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/gen/assets.gen.dart';
import 'package:test_project/ui/splash/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());
    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(22),
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0,
                    end: 1,
                  ).animate(
                    CurvedAnimation(
                      curve: Curves.easeInOut,
                      parent: controller.animation,
                    ),
                  ),
                  child: Image.asset(Assets.images.aksharLogo.path),
                ))));
  }
}
