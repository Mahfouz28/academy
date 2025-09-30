import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/status_badge.dart';
import 'package:academy/features/subscriptions/presentation/widgets/renew_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowSubsCard extends StatelessWidget {
  const ShowSubsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Text(
                  'Student Name',
                  style: TextStyle(
                    color: AppColors.foreground,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                StatusBadge(
                  backgroundColor: AppColors.chart2,
                  borderColor: AppColors.chart2,
                  textColor: AppColors.foreground,
                ),
              ],
            ),

            8.verticalSpace,

            // Subscription price
            Text(
              '\$ 140 / month',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            12.verticalSpace,

            // Dates
            Text(
              'Start: ',
              style: TextStyle(
                color: AppColors.mutedForeground,
                fontSize: 12.sp,
              ),
            ),
            4.verticalSpace,
            Text(
              'End: ',
              style: TextStyle(
                color: AppColors.mutedForeground,
                fontSize: 12.sp,
              ),
            ),

            8.verticalSpace,

            // Days remaining
            Row(
              children: [
                Text(
                  'Days remaining: ',
                  style: TextStyle(
                    color: AppColors.foreground,
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  '20',
                  style: TextStyle(
                    color: AppColors.chart3,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            16.verticalSpace,

            // Renew Button
            RenewButton(),
          ],
        ),
      ),
    );
  }
}
