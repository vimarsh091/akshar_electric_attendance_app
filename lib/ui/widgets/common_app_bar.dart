import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_project/app/app_color.dart';

class CommonAppBar extends StatelessWidget {
  final bool? showLeading;
  final VoidCallback onLeadingTap;
  final String title;
  final IconData? leadingIcon;

  const CommonAppBar(
      {super.key,
      this.showLeading,
      required this.onLeadingTap,
      required this.title,
      this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          8.verticalSpace,
          Stack(
            children: [
              if (showLeading == true)
                GestureDetector(
                  onTap: () => onLeadingTap.call(),
                  child: Positioned(
                    left: 0,
                    child: Padding(
                      padding:  EdgeInsets.only(left:20.w),
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
