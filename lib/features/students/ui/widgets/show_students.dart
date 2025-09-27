import 'package:academy/core/helpers/navigat.dart';
import 'package:academy/core/router/routs.dart';
import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/custom_action_button.dart';
import 'package:academy/core/widgets/status_badge.dart';
import 'package:academy/features/students/logic/cubit/student_cubit.dart';
import 'package:academy/features/students/ui/widgets/edite_student_dialog.dart';
import 'package:academy/features/students/ui/widgets/student_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowStudents extends StatelessWidget {
  const ShowStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit, StudentState>(
      listener: (context, state) {
        if (state is UpdateStudentSuccess) {
          context.pushReplacementNamed(Routes.students);
        }
        if (state is DeleteStudentSuccess) {
          context.pushReplacementNamed(Routes.students);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Student deleted successfully!')),
          );
        }
        if (state is GetStudentsSuccess) {
        } else if (state is GetStudentsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load students: ${state.error}')),
          );
        }
      },
      builder: (context, state) {
        if (state is GetStudentsSuccess) {
          final students = state.students;

          if (students.isEmpty) {
            return Container(
              margin: EdgeInsets.only(top: 25.h),
              padding: EdgeInsets.all(20.w),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.accentForeground,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: AppColors.border, width: 2),
              ),
              child: Center(
                child: Text(
                  "No students found",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mutedForeground,
                  ),
                ),
              ),
            );
          }

          return Container(
            margin: EdgeInsets.only(top: 25.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.accentForeground,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.border, width: 2),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 27.h,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Students List (${students.length})',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.chart1,
                      ),
                    ),
                  ),
                ),
                Divider(color: AppColors.border, thickness: 2),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final student = students[index];
                    return StudentCard(
                      name: student.name,
                      age: student.age ?? 0,
                      phone: student.phone ?? "",
                      badges: [
                        StatusBadge(
                          text: student.beltLevel,
                          backgroundColor: Colors.blue.withOpacity(.3),
                          borderColor: Colors.blue,
                          textColor: Colors.blue.shade200,
                        ),
                        StatusBadge(
                          text: student.subscriptionStatus,
                          backgroundColor: Colors.greenAccent.withOpacity(.3),
                          borderColor: Colors.green,
                          textColor: Colors.green.shade200,
                        ),
                      ],
                      editButton: CustomActionButton(
                        width: 180,
                        backgroundColor: const Color(0xFF1F2937),
                        borderColor: const Color(0xFF374151),
                        textColor: Colors.white,
                        icon: Icons.edit,
                        text: 'Edit',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return BlocProvider.value(
                                value: context.read<StudentCubit>(),
                                child: EditStudentDialog(student: student),
                              );
                            },
                          );
                        },
                      ),
                      deleteButton: CustomActionButton(
                        width: 50,
                        backgroundColor: const Color(0xFF1F2937),
                        borderColor: AppColors.destructive,
                        textColor: Colors.red,
                        icon: Icons.delete,
                        text: null,
                        onPressed: () {
                          context.read<StudentCubit>().deleteStudent(
                            student.id,
                          );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox.shrink(),
                  itemCount: students.length,
                ),
              ],
            ),
          );
        }

        if (state is GetStudentsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return const Center(child: Text("Press refresh to load students"));
      },
    );
  }
}
