import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/app_card.dart';
import 'package:academy/core/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendancrHeader extends StatelessWidget {
  final int attend;
  final int absent;

  const AttendancrHeader({
    super.key,
    required this.attend,
    required this.absent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Attendance',
          style: TextStyle(
            fontSize: 25,
            color: AppColors.accent,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Text(
          'Mark student attendance for classes',
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
        ),
        AppCard(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.r),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month, color: AppColors.accent),
                    10.horizontalSpace,
                    Text(
                      "Today's Classes",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.chart1,
                      ),
                    ),
                  ],
                ),
              ),
              12.verticalSpace,
              Divider(color: AppColors.border, thickness: 2),
              30.verticalSpace,

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.r),
                child: Row(
                  children: [
                    StatusBadge(
                      width: 90,

                      text: 'Present: $attend',
                      backgroundColor: Colors.green.withOpacity(0.3),
                      borderColor: Colors.green,
                      textColor: Colors.white,
                    ),
                    14.horizontalSpace,
                    StatusBadge(
                      width: 90,

                      text: 'Absent: $absent',
                      backgroundColor: Colors.red.withOpacity(0.3),
                      borderColor: Colors.red,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ],
    );
  }
}
