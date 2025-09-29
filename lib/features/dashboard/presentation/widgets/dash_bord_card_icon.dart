import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashBordCardIcon extends StatelessWidget {
  final Color color;
  final IconData? icon;
  final Color backgroundColor;
  final Color borderColor;
  final int? width;
  final int? height;

  const DashBordCardIcon({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    this.width,
    this.height,
    this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor),
      ),
      child: Center(child: Icon(icon, color: color, size: 20)),
    );
  }
}
