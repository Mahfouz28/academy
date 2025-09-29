import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusBadge extends StatelessWidget {
  final String? text;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final int? width;
  final int? height;

  const StatusBadge({
    super.key,
    this.text,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: borderColor),
      ),
      child: Center(
        child: text != null
            ? Text(text!, style: TextStyle(color: textColor))
            : const SizedBox.shrink(),
      ),
    );
  }
}
