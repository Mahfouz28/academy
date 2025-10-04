import 'package:academy/core/helpers/navigat.dart';
import 'package:academy/core/router/routs.dart';
import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/app_bar.dart';
import 'package:academy/core/widgets/app_card.dart';
import 'package:academy/core/widgets/drawer.dart';
import 'package:academy/core/widgets/show_info_card.dart';
import 'package:academy/core/widgets/status_badge.dart';
import 'package:academy/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:academy/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:academy/features/dashboard/presentation/widgets/select_belt_level.dart';
import 'package:academy/features/dashboard/presentation/widgets/select_type_serch.dart';
import 'package:academy/features/students/ui/widgets/searche_bar.dart';
import 'package:academy/features/students/ui/widgets/student_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalStudentDashboardPage extends StatelessWidget {
  const TotalStudentDashboardPage({super.key});

  Color getBeltColor(String beltLevel) {
    switch (beltLevel) {
      case "White":
        return Colors.white;
      case "Yellow":
      case "Yellow 2":
        return Colors.yellow;
      case "Orange":
      case "Orange 2":
        return Colors.orange;
      case "Green":
      case "Green 2":
        return Colors.green;
      case "Blue":
      case "Blue 2":
        return Colors.blue;
      case "Brown":
      case "Brown 2":
        return Colors.brown;
      case "Black":
        return Colors.black;
      default:
        return Colors.grey; // fallback color
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AcademyAppBar(),
      drawer: AcademyDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---- Header Section ----
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.people_alt_outlined,
                    color: AppColors.accent,
                    size: 22.sp,
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'All Students',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Complete list of academy students with detailed information',
                          style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.background,
                      padding: EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: AppColors.border),
                      ),
                    ),
                    onPressed: () => context.pushNamed(Routes.addStudent),
                    child: Row(
                      children: [
                        Icon(Icons.add, color: AppColors.accent, size: 18.sp),
                        5.horizontalSpace,
                        Text(
                          'Add Student',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              20.verticalSpace,

              /// ---- Dashboard Summary ----
              BlocBuilder<DashboardCubit, DashboardState>(
                buildWhen: (previous, current) =>
                    current is GetAllStudentsSuccess,
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

                    final attendanceToday = state.attendance.where(
                      (element) => element['status'] == 'Present',
                    );

                    final activeSubs = students
                        .where((s) => s.subscriptionStatus == 'active')
                        .length;
                    final expiredSubs = students
                        .where((s) => s.subscriptionStatus == 'expired')
                        .length;

                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ShowInfoCard(
                                title: 'Total\nStudents',
                                countColor: Colors.blue,
                                count: totalStudents.toString(),
                              ),
                            ),
                            8.horizontalSpace,
                            Expanded(
                              child: ShowInfoCard(
                                title: 'Attendance\nToday',
                                countColor: Colors.orange,
                                count: attendanceToday.length.toString(),
                              ),
                            ),
                          ],
                        ),
                        12.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: ShowInfoCard(
                                title: 'Active\nSubscriptions',
                                countColor: Colors.green,
                                count: activeSubs.toString(),
                              ),
                            ),
                            8.horizontalSpace,
                            Expanded(
                              child: ShowInfoCard(
                                title: 'Expired\nSubscriptions',
                                countColor: Colors.red,
                                count: expiredSubs.toString(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: Text('Press refresh to load students'),
                  );
                },
              ),
              20.verticalSpace,

              /// ---- Search & Filter ----
              AppCard(
                child: Column(
                  children: [
                    const SearcheBar(),
                    20.verticalSpace,
                    const SelectTypeSerch(),
                    20.verticalSpace,
                    const SelectBeltLevel(),
                  ],
                ),
              ),
              20.verticalSpace,

              /// ---- Student List ----
              BlocBuilder<DashboardCubit, DashboardState>(
                builder: (context, state) {
                  if (state is GetAllStudentsLoading ||
                      state is SearchStudentsLoading ||
                      state is FilterStudentsByBeltLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is GetAllStudentsFailure ||
                      state is SearchStudentsFailure ||
                      state is FilterStudentsByBeltFailure) {
                    final error = (state is GetAllStudentsFailure)
                        ? state.error
                        : (state is SearchStudentsFailure)
                        ? state.error
                        : (state as FilterStudentsByBeltFailure).error;
                    return Center(child: Text('Error: $error'));
                  }

                  if (state is GetAllStudentsSuccess ||
                      state is SearchStudentsSuccess ||
                      state is FilterStudentsByBeltSuccess) {
                    final students = (state is GetAllStudentsSuccess)
                        ? state.students
                        : (state is SearchStudentsSuccess)
                        ? state.students
                        : (state as FilterStudentsByBeltSuccess).students;

                    if (students.isEmpty) {
                      return const Center(child: Text('No students found'));
                    }

                    return AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Students (${students.length})',
                            style: TextStyle(
                              color: AppColors.accent,
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
                            separatorBuilder: (_, __) => SizedBox(height: 16.h),
                            itemBuilder: (context, index) {
                              final student = students[index];
                              return StudentCard(
                                name: student.name,
                                age: student.age,
                                phone: student.phone,
                                badges: [
                                  StatusBadge(
                                    text: student.subscriptionStatus,
                                    backgroundColor:
                                        student.subscriptionStatus == 'active'
                                        ? Colors.green.withOpacity(0.15)
                                        : Colors.red.withOpacity(0.15),
                                    borderColor:
                                        student.subscriptionStatus == 'active'
                                        ? Colors.green
                                        : Colors.red,
                                    textColor:
                                        student.subscriptionStatus == 'active'
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  StatusBadge(
                                    text: student.beltLevel,
                                    backgroundColor: getBeltColor(
                                      student.beltLevel,
                                    ).withOpacity(.3),

                                    borderColor: getBeltColor(
                                      student.beltLevel,
                                    ),
                                    textColor: Colors.white,
                                  ),
                                ],
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
    );
  }
}
