import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/app_bar.dart';
import 'package:academy/core/widgets/app_card.dart';
import 'package:academy/core/widgets/drawer.dart';
import 'package:academy/core/widgets/show_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import 'package:timeago/timeago.dart' as timeago;

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AcademyAppBar(),
      drawer: AcademyDrawer(),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is GetAllStudentsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetAllStudentsFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }
          if (state is GetAllStudentsSuccess) {
            final students = state.students;
            final totalStudents = students.length;
            final attendance = state.attendance;
            final attendanceTOday = attendance.where(
              (element) => element['status'] == 'Present',
            );

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(28.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: 25,
                        color: AppColors.accent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Manage your karate academy students',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13.sp,
                      ),
                    ),

                    Column(
                      children: [
                        Row(
                          children: [
                            ShowInfoCard(
                              title: 'Total\nStudents',
                              count: totalStudents.toString(),
                              icon: Icons.people,
                              iconColor: Colors.blue,
                              iconBackgroundColor: Colors.blue.withOpacity(
                                0.15,
                              ),
                              iconBorderColor: Colors.blue,
                            ),
                            8.horizontalSpace,
                            ShowInfoCard(
                              title: 'Attendance\ntoday',
                              count: attendanceTOday.length.toString(),
                              icon: Icons.calendar_today_outlined,
                              iconColor: Colors.orange,
                              iconBackgroundColor: Colors.orange.withOpacity(
                                0.15,
                              ),
                              iconBorderColor: Colors.orange,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ShowInfoCard(
                              title: 'Active\nSubscriptions',
                              count:
                                  '${students.where((s) => s.subscriptionStatus == 'active').length}',
                              icon: Icons.payment,
                              iconColor: Colors.green,
                              iconBackgroundColor: Colors.green.withOpacity(
                                0.15,
                              ),
                              iconBorderColor: Colors.green,
                            ),
                            8.horizontalSpace,
                            ShowInfoCard(
                              title: 'Expired\nSubscriptions',
                              count:
                                  '${students.where((s) => s.subscriptionStatus == 'expired').length}',
                              icon: Icons.warning_amber_rounded,
                              iconColor: Colors.red,
                              iconBackgroundColor: Colors.red.withOpacity(0.15),
                              iconBorderColor: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.r),
                            child: Text(
                              'Recent Registrations',
                              style: TextStyle(
                                color: AppColors.accent,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Divider(thickness: 2, color: AppColors.border),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: students.length > 5
                                ? 5
                                : students.length,
                            separatorBuilder: (_, index) =>
                                Divider(color: AppColors.border),
                            itemBuilder: (context, index) {
                              final student = state.students[index];

                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.r,
                                  vertical: 8.h,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              student.name,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppColors
                                                    .destructiveForeground,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 4.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  student.subscriptionStatus ==
                                                      'active'
                                                  ? Colors.green.withOpacity(
                                                      0.2,
                                                    )
                                                  : Colors.red.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                            child: Text(
                                              student.subscriptionStatus,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color:
                                                    student.subscriptionStatus ==
                                                        'active'
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 8),

                                    // التاريخ
                                    Text(
                                      timeago.format(student.createdAt),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.border,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(child: Text('Press refresh to load students'));
        },
      ),
    );
  }
}
