import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/app_bar.dart';
import 'package:academy/core/widgets/app_card.dart';
import 'package:academy/core/widgets/drawer.dart';
import 'package:academy/features/dashboard/presentation/widgets/dash_board_card.dart';
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
                            DashBoardCard(
                              title: 'Total\nStudents',
                              count: totalStudents.toString(),
                              icon: Icons.people,
                              iconColor: AppColors.chart1,
                              iconBackgroundColor: AppColors.chart1,
                              iconBorderColor: AppColors.chart1,
                            ),
                            8.horizontalSpace,

                            DashBoardCard(
                              title: 'Attendance\ntoday',

                              count: attendanceTOday.length.toString(),
                              icon: Icons.calendar_today_outlined,
                              iconColor: AppColors.chart2,
                              iconBackgroundColor: AppColors.chart2,
                              iconBorderColor: AppColors.chart2,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            DashBoardCard(
                              title: 'Active\nSubscriptions',
                              count: '5',
                              icon: Icons.payment,
                              iconColor: AppColors.chart1,
                              iconBackgroundColor: AppColors.chart1,
                              iconBorderColor: AppColors.chart1,
                            ),
                            8.horizontalSpace,
                            DashBoardCard(
                              title: 'Expired\nSubscriptions',
                              count: '20',
                              icon: Icons.warning_amber_rounded,
                              iconColor: AppColors.destructive,
                              iconBackgroundColor: AppColors.destructive,
                              iconBorderColor: AppColors.destructive,
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
                            itemCount: 5,
                            separatorBuilder: (_, __) =>
                                Divider(color: AppColors.border),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.r,
                                  vertical: 8.h,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      state.students[index].name,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.accent,
                                      ),
                                    ),
                                    const Spacer(),

                                    Text(
                                      timeago.format(
                                        state.students[index].createdAt,
                                      ),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.border,
                                      ),
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
