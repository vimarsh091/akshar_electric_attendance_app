import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_project/app/app_color.dart';

class CommonAppBar extends StatelessWidget {
  final bool? showLeading;
  final bool? showSufixIcon;
  final VoidCallback onLeadingTap;
  final VoidCallback? onSufixTap;
  final String title;
  final IconData? leadingIcon;
  final GlobalKey? popupKey;

  const CommonAppBar(
      {super.key,
      this.showLeading,
      required this.onLeadingTap,
      required this.title,
      this.leadingIcon,
      this.showSufixIcon = false,
      this.onSufixTap,
      this.popupKey});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          8.verticalSpace,
          Stack(
            children: [
              if (showLeading == true)
                Positioned(
                  left: 0,
                  child: GestureDetector(
                    onTap: () => onLeadingTap.call(),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Icon(
                        leadingIcon ?? Icons.arrow_back,
                        color: AppColors.colorAppTheme,
                      ),
                    ),
                  ),
                ),
              Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (showSufixIcon == true)
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    key: popupKey,
                    onTap: () => onSufixTap?.call(),
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: const Icon(
                        Icons.settings_accessibility,
                        color: AppColors.colorAppTheme,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          8.verticalSpace,
          Divider(
            height: 1,
            color: AppColors.colorAppTheme.withAlpha(90),
            thickness: 1,
          )
        ],
      ),
    );
  }
}
