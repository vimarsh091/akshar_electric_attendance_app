import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/app/app_color.dart';
import 'package:test_project/app/app_route.dart';
import 'package:test_project/ui/splash/splash_page.dart';

Future<void> main() async {
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
    statusBarColor: AppColors.colorAppTheme, // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.colorAppTheme),
          useMaterial3: true,
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        getPages: AppRoutes.routes,
        home: const SplashPage(),
      ),
    );
  }
}
