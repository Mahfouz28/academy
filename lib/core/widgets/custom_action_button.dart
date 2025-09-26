import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomActionButton extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final IconData icon;
  final String? text;
  final VoidCallback onPressed;
  final int width;

  const CustomActionButton({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.icon,
    this.text,
    required this.onPressed,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,

      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          overlayColor: backgroundColor.withOpacity(0.2),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor),
            if (text != null) ...[
              SizedBox(width: 5.w),
              Text(text!, style: TextStyle(color: textColor)),
            ],
          ],
        ),
      ),
    );
  }
}
