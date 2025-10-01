import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/status_badge.dart';
import 'package:academy/features/subscriptions/presentation/widgets/renew_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowSubsCard extends StatelessWidget {
  final String studentId;
  final VoidCallback onRenew;
  final bool isLoading;

  final String studentName;
  final String status;
  final DateTime startDate;
  final DateTime endDate;
  // final int daysRemaining;
  final double price;

  const ShowSubsCard({
    required this.isLoading,
    required this.studentName,
    required this.status,
    required this.startDate,
    required this.endDate,
    // required this.daysRemaining,
    this.price = 140,
    required this.studentId,
    required this.onRenew,
  });

  Color _getStatusColor() {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'expired':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return AppColors.mutedForeground;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

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
                  studentName,
                  style: TextStyle(
                    color: AppColors.foreground,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                StatusBadge(
                  text: status.toUpperCase(),
                  backgroundColor: statusColor.withOpacity(0.1),
                  borderColor: statusColor,
                  textColor: statusColor,
                ),
              ],
            ),

            8.verticalSpace,

            // Subscription price
            Text(
              '\$ $price / month',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            12.verticalSpace,

            // Dates
            Text(
              'Start: ${startDate.toString().split(' ')[0]}',
              style: TextStyle(
                color: AppColors.mutedForeground,
                fontSize: 12.sp,
              ),
            ),
            4.verticalSpace,
            Text(
              'End: ${endDate.toString().split(' ')[0]}',
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
                // Text(
                //   // '$daysRemaining',
                //   style: TextStyle(
                //     color: AppColors.chart3,
                //     fontSize: 12.sp,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
              ],
            ),

            16.verticalSpace,

            // Renew Button (only if expired or pending)
            if (status != 'active') RenewButton(onPressed: onRenew),
          ],
        ),
      ),
    );
  }
}
