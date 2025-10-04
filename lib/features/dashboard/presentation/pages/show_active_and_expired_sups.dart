import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/app_bar.dart';
import 'package:academy/core/widgets/app_card.dart';
import 'package:academy/core/widgets/drawer.dart';
import 'package:academy/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:academy/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:academy/features/dashboard/presentation/widgets/select_type_serch.dart';
import 'package:academy/features/dashboard/presentation/widgets/show_subs_info.dart';
import 'package:academy/features/students/ui/widgets/searche_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                BlocBuilder<DashboardCubit, DashboardState>(
                  buildWhen: (previous, current) =>
                      current is GetAllStudentsLoading ||
                      current is GetAllStudentsSuccess ||
                      current is GetAllStudentsFailure,
                  builder: (context, state) {
                    if (state is GetAllStudentsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is GetAllStudentsFailure) {
                      return Center(child: Text('Error: ${state.error}'));
                    }
                    if (state is GetAllStudentsSuccess) {
                      final students = state.students;
                      final activeStudents = students
                          .where((s) => s.subscriptionStatus == 'active')
                          .length;
                      final expiredStudents = students
                          .where((s) => s.subscriptionStatus == 'expired')
                          .length;
                      final totalStudents = students.length;

                      double totalRevenue = 0;
                      for (var student in students) {
                        if (student.subscriptionStatus == 'active') {
                          totalRevenue += 140;
                        }
                      }

                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: AppCard(
                                  child: Center(
                                    child: Text(
                                      'Active: $activeStudents',
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
                                      'Expired: $expiredStudents',
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
                                      'Total Students: $totalStudents',
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
                                          '\$ $totalRevenue',
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
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),

                20.verticalSpace,

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
                BlocBuilder<DashboardCubit, DashboardState>(
                  builder: (context, state) {
                    if (state is GetAllStudentsLoading ||
                        state is SearchStudentsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is GetAllStudentsFailure ||
                        state is SearchStudentsFailure) {
                      final error = (state is GetAllStudentsFailure)
                          ? state.error
                          : (state as SearchStudentsFailure).error;
                      return Center(child: Text('Error: $error'));
                    }

                    if (state is GetAllStudentsSuccess ||
                        state is SearchStudentsSuccess) {
                      final students = (state is GetAllStudentsSuccess)
                          ? state.students
                          : (state as SearchStudentsSuccess).students;
                      return AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Subscriptions (${students.length} of ${students.length})',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Divider(thickness: 1, color: AppColors.border),
                            12.verticalSpace,
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: students.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 16.h),
                              itemBuilder: (context, index) {
                                final student = students[index];
                                return ShowSubsInfo(
                                  isLoading: false,
                                  studentName: student.name,
                                  status: student.subscriptionStatus,
                                  startDate: DateTime.now(),
                                  endDate: DateTime.now().add(
                                    const Duration(days: 30),
                                  ),
                                  studentId: student.id,
                                  onRenew: () {},
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }

                    return const Center(
                      child: Text('Press refresh to load students'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
