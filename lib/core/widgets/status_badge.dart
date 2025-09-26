import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusBadge extends StatelessWidget {
  final String? text;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  const StatusBadge({
    super.key,
    this.text,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
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
