import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/app_card.dart';
import 'package:academy/core/widgets/drawer.dart';
import 'package:academy/core/widgets/show_info_card.dart';
import 'package:academy/features/subscriptions/presentation/widgets/show_subs_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionsPage extends StatelessWidget {
  const SubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Subscriptions Page'),
        backgroundColor: AppColors.card,
        foregroundColor: AppColors.foreground,
        elevation: 0,
      ),
      drawer: AcademyDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 22.r, vertical: 16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Title
              Text(
                'Subscriptions',
                style: TextStyle(
                  fontSize: 25.sp,
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              4.verticalSpace,
              Text(
                'Manage student subscriptions and payments',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 13.sp,
                  color: AppColors.mutedForeground,
                ),
              ),

              16.verticalSpace,

              // Info cards row 1
              Row(
                children: [
                  ShowInfoCard(
                    title: 'Active',
                    count: '5',
                    countColor: AppColors.chart2,

                    icon: Icons.check,
                    iconColor: AppColors.chart2,
                    iconBackgroundColor: AppColors.chart2,
                    iconBorderColor: AppColors.chart2,
                  ),
                  12.horizontalSpace,
                  ShowInfoCard(
                    title: 'Expiring Soon',
                    count: '2',
                    countColor: AppColors.chart1,

                    icon: Icons.warning_amber_rounded,
                    iconColor: AppColors.chart1,
                    iconBackgroundColor: AppColors.chart1,
                    iconBorderColor: AppColors.chart1,
                  ),
                ],
              ),

              12.verticalSpace,

              // Info cards row 2
              Row(
                children: [
                  ShowInfoCard(
                    title: 'Expired',
                    count: '1',
                    countColor: AppColors.destructive,
                    icon: Icons.close_rounded,
                    iconColor: AppColors.destructive,
                    iconBackgroundColor: AppColors.destructive,
                    iconBorderColor: AppColors.destructive,
                  ),
                  12.horizontalSpace,
                  ShowInfoCard(
                    title: 'Monthly Revenue',
                    count: '\$ 455',
                    countColor: AppColors.chart3,
                    icon: Icons.monetization_on,
                    iconColor: AppColors.chart2,
                    iconBackgroundColor: AppColors.chart2,
                    iconBorderColor: AppColors.chart2,
                  ),
                ],
              ),

              20.verticalSpace,

              AppCard(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on_outlined,
                            color: AppColors.accent,
                          ),
                          8.horizontalSpace,
                          Text(
                            'All Subscriptions',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.foreground,
                            ),
                          ),
                        ],
                      ),

                      16.verticalSpace,

                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (_, __) => const ShowSubsCard(),
                        separatorBuilder: (_, __) => SizedBox(height: 16.h),
                        itemCount: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
