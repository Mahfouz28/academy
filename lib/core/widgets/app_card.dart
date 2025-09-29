import 'package:academy/core/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCard extends StatelessWidget {
  final Widget child;

  const AppCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.h),
      padding: EdgeInsets.symmetric(vertical: 27.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.accentForeground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border, width: 2),
      ),
      child: child,
    );
  }
}
