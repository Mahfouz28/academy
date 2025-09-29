import 'package:academy/core/widgets/app_card.dart';
import 'package:academy/features/dashboard/presentation/widgets/dash_bord_card_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashBoardCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final Color iconBorderColor;
  const DashBoardCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.iconBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppCard(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  DashBordCardIcon(
                    backgroundColor: iconBackgroundColor.withOpacity(0.3),
                    borderColor: iconBorderColor,
                    color: iconColor,
                    icon: icon,
                  ),
                ],
              ),
              Text(count),
            ],
          ),
        ),
      ),
    );
  }
}
