import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ShowSubsInfo extends StatelessWidget {
  final String studentId;
  final VoidCallback onRenew;
  final bool isLoading;

  final String studentName;
  final String status;
  final DateTime startDate;
  final DateTime endDate;
  final double price;

  const ShowSubsInfo({
    super.key,
    required this.isLoading,
    required this.studentName,
    required this.status,
    required this.startDate,
    required this.endDate,
    this.price = 140,
    required this.studentId,
    required this.onRenew,
  });

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
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
    final dateFormat = DateFormat('MMM d, yyyy');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 14.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name + Price
            Row(
              children: [
                Text(
                  studentName,
                  style: TextStyle(
                    color: AppColors.foreground,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '\$$price/month',
                  style: TextStyle(
                    color: AppColors.accent, // أصفر
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            6.verticalSpace,

            // Dates + Status
            Row(
              children: [
                Text(
                  '${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}',
                  style: TextStyle(
                    color: AppColors.mutedForeground,
                    fontSize: 12.sp,
                  ),
                ),
                const Spacer(),
                StatusBadge(
                  text: status[0].toUpperCase() + status.substring(1),
                  backgroundColor: statusColor.withOpacity(0.15),
                  borderColor: statusColor,
                  textColor: statusColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
