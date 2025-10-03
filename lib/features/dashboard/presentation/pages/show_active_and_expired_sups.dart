import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/app_bar.dart';
import 'package:academy/core/widgets/app_card.dart';
import 'package:academy/core/widgets/drawer.dart';
import 'package:academy/features/dashboard/presentation/widgets/select_type_serch.dart';
import 'package:academy/features/dashboard/presentation/widgets/show_subs_info.dart';
import 'package:academy/features/students/ui/widgets/searche_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowActiveAndExpiredSups extends StatelessWidget {
  const ShowActiveAndExpiredSups({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AcademyAppBar(),
      drawer: AcademyDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0).r,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,

                /// --- Header with Back Button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        overlayColor: AppColors.accent.withOpacity(0.2),
                        backgroundColor: AppColors.background,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: AppColors.border),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Icon(Icons.payment, color: AppColors.accent, size: 28.sp),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Subscription Management',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          6.verticalSpace,
                          Text(
                            'Complete overview of student subscriptions and revenue',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,

                /// --- Summary Cards
                Row(
                  children: [
                    Expanded(
                      child: AppCard(
                        child: Center(
                          child: Text(
                            'Active: 4',
                            style: TextStyle(
                              color: AppColors.chart2,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: AppCard(
                        child: Center(
                          child: Text(
                            'Expired: 2',
                            style: TextStyle(
                              color: AppColors.destructive,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                12.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: AppCard(
                        child: Center(
                          child: Text(
                            'Total Students: 4',
                            style: TextStyle(
                              color: AppColors.chart3,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: AppCard(
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                'Monthly Revenue',
                                style: TextStyle(
                                  color: AppColors.chart1,
                                  fontSize: 14.sp,
                                ),
                              ),
                              6.verticalSpace,
                              Text(
                                '\$455',
                                style: TextStyle(
                                  color: AppColors.chart1,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,

                // /// --- Revenue Analytics Section
                // AppCard(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Padding(
                //         padding: EdgeInsets.all(12.r),
                //         child: Row(
                //           children: [
                //             Icon(
                //               Icons.attach_money_outlined,
                //               color: AppColors.accent,
                //               size: 22.sp,
                //             ),
                //             8.horizontalSpace,
                //             Text(
                //               'Revenue Analytics',
                //               style: TextStyle(
                //                 color: AppColors.accent,
                //                 fontSize: 18.sp,
                //                 fontWeight: FontWeight.w500,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Divider(thickness: 1, color: AppColors.border),
                //       12.verticalSpace,
                //       Center(
                //         child: Text(
                //           'Coming soon...',
                //           style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                //         ),
                //       ),
                //       12.verticalSpace,

                //     ],
                //   ),
                // ),
                AppCard(
                  child: Column(
                    children: [
                      SearcheBar(),
                      20.verticalSpace,
                      SelectTypeSerch(),
                    ],
                  ),
                ),
                20.verticalSpace,
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Subscriptions (8 of 8)', style: TextStyle()),
                      Divider(thickness: 1, color: AppColors.border),
                      12.verticalSpace,
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          // Replace with your actual subscription data
                          final isLoading = false;
                          final studentName = 'Student ${index + 1}';
                          final status = index % 2 == 0 ? 'active' : 'expired';
                          final startDate = DateTime.now().subtract(
                            Duration(days: 30 * index),
                          );
                          final endDate = DateTime.now().add(
                            Duration(days: 30 * (index + 1)),
                          );
                          final studentId = 'ID${index + 1000}';
                          void onRenew() {}
                          return ShowSubsInfo(
                            isLoading: isLoading,
                            studentName: studentName,
                            status: status,
                            startDate: startDate,
                            endDate: endDate,
                            studentId: studentId,
                            onRenew: onRenew,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.h),
                        itemCount: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
