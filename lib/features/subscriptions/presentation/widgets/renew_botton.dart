import 'package:academy/core/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RenewButton extends StatefulWidget {
  final VoidCallback onPressed;
  const RenewButton({super.key, required this.onPressed});

  @override
  State<RenewButton> createState() => _RenewButtonState();
}

class _RenewButtonState extends State<RenewButton> {
  bool _pressed = false;

  void _onTap() {
    widget.onPressed();

    setState(() {
      _pressed = !_pressed;
    });

    // Reset back after short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => _pressed = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: _pressed ? 8.h : 10.h,
          horizontal: 12.w,
        ),
        decoration: BoxDecoration(
          color: _pressed
              ? AppColors.secondary.withOpacity(0.8)
              : AppColors.secondary,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: _pressed
              ? []
              : [
                  BoxShadow(
                    color: AppColors.chart1.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sync_rounded, color: AppColors.chart1, size: 18.sp),
            6.horizontalSpace,
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _pressed ? 0.7 : 1.0,
              child: Text(
                'Renew Subscription',
                style: TextStyle(
                  color: AppColors.chart1.withOpacity(_pressed ? 0.7 : 1.0),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
