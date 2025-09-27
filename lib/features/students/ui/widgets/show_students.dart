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

  Color getSubscriptionColor(String subscriptionStatus) {
    switch (subscriptionStatus) {
      case "pending":
        return Colors.orange;
      case "active":
        return Colors.green;
      case "expired":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

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
                          backgroundColor: getBeltColor(
                            student.beltLevel,
                          ).withOpacity(0.3),
                          borderColor: getBeltColor(student.beltLevel),
                          textColor:
                              getBeltColor(
                                    student.beltLevel,
                                  ).computeLuminance() >
                                  0.5
                              ? Colors.black
                              : Colors.white,
                        ),
                        StatusBadge(
                          text: student.subscriptionStatus,
                          backgroundColor: getSubscriptionColor(
                            student.subscriptionStatus,
                          ).withOpacity(.3),
                          borderColor: getSubscriptionColor(
                            student.subscriptionStatus,
                          ),
                          textColor: Colors.white,
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
                          showDialog(
                            context: context,
                            builder: (dialogContext) => AlertDialog(
                              title: const Text("Delete Student"),
                              content: const Text(
                                "Are you sure you want to delete this student?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(dialogContext),
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<StudentCubit>().deleteStudent(
                                      student.id,
                                    );
                                    Navigator.pop(dialogContext);
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            ),
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
