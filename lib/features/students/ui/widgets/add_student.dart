import 'package:academy/core/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Students'),
        Text(
          'Manage your karate academy students',
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13.sp),
        ),
        16.verticalSpace,
        SizedBox(
          width: double.infinity,
          height: 37.h,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.r),
              ),
            ),
            onPressed: () {},
            child: Text(
              '+    Add Student',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
