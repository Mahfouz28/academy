import 'package:academy/core/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowAttendCard extends StatelessWidget {
  final String name;
  final int age;
  final String phone;
  final List<StatusBadge>? badges;

  final Color backgroundColor;
  final Color borderColor;

  const ShowAttendCard({
    super.key,
    required this.name,
    required this.age,
    required this.phone,
    this.badges,

    this.backgroundColor = const Color(0xFF1F2937),
    this.borderColor = const Color(0xFF374151),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Text(
                  age.toString(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            4.verticalSpace,
            Text(phone, style: TextStyle(color: Colors.grey)),
            10.verticalSpace,
            Row(
              children: [
                if (badges != null)
                  for (int i = 0; i < badges!.length; i++) ...[
                    badges![i],
                    if (i != badges!.length - 1) 5.horizontalSpace,
                  ],
              ],
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}
