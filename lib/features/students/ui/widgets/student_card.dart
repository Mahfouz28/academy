import 'package:academy/core/widgets/custom_action_button.dart';
import 'package:academy/core/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final int age;
  final String phone;
  final List<StatusBadge> badges;
  final CustomActionButton? editButton;
  final CustomActionButton? deleteButton;
  final Color backgroundColor;
  final Color borderColor;

  const StudentCard({
    super.key,
    required this.name,
    required this.age,
    required this.phone,
    required this.badges,
    this.editButton,
    this.deleteButton,
    this.backgroundColor = const Color(0xFF1F2937),
    this.borderColor = const Color(0xFF374151),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 22.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
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
                for (int i = 0; i < badges.length; i++) ...[
                  badges[i],
                  if (i != badges.length - 1) 5.horizontalSpace,
                ],
              ],
            ),
            10.verticalSpace,
            Row(children: [?editButton, 12.horizontalSpace, ?deleteButton]),
          ],
        ),
      ),
    );
  }
}
