import 'package:academy/core/helpers/navigat.dart';
import 'package:academy/core/helpers/snack_bar_helper.dart';
import 'package:academy/core/router/routs.dart';
import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/app_bar.dart';
import 'package:academy/core/widgets/app_card.dart';
import 'package:academy/core/widgets/drawer.dart';
import 'package:academy/features/attendance/logic/cubit/attendace_cubit.dart';
import 'package:academy/features/attendance/ui/widgets/attend_card.dart';
import 'package:academy/features/attendance/ui/widgets/attendancr_header.dart';
import 'package:academy/features/students/data/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  int counterPresent = 0;
  int counterAbsent = 0;

  final Map<String, String> attendanceMap = {};

  void toggleAttend(Student student) {
    setState(() {
      if (attendanceMap[student.id] == "Absent") counterAbsent--;

      if (attendanceMap[student.id] != "Present") {
        attendanceMap[student.id] = "Present";
        counterPresent++;
      }
    });
  }

  void toggleAbsent(Student student) {
    setState(() {
      if (attendanceMap[student.id] == "Present") counterPresent--;

      if (attendanceMap[student.id] != "Absent") {
        attendanceMap[student.id] = "Absent";
        counterAbsent++;
      }
    });
  }

  void saveAttendance(BuildContext context) {
    final cubit = context.read<AttendanceCubit>();
    final date = DateTime.now();

    attendanceMap.forEach((studentId, status) {
      cubit.insertAttendance(studentId: studentId, date: date, status: status);
      SnackBarHelper.show(
        context,
        'Attendance saved successfully!',
        type: SnackBarType.success,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<AttendanceCubit>().getStudents();
  }

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
        child: Padding(
          padding: EdgeInsets.all(22.0.r),
          child: BlocConsumer<AttendanceCubit, AttendanceState>(
            builder: (context, state) {
              if (state is GetAttendanceLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetAttendanceFailure) {
                return Center(child: Text("Error: ${state.error}"));
              }

              if (state is GetAttendanceSuccess) {
                final students = state.students;

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AttendancrHeader(
                        attend: counterPresent,
                        absent: counterAbsent,
                      ),
                      AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0.r),
                              child: Row(
                                children: [
                                  Text(
                                    'Students Attendance',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.chart1,
                                    ),
                                  ),
                                  const Spacer(),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.pushNamed(Routes.showAttendance);
                                    },
                                    child: const Text(' See Attendance'),
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: AppColors.border),
                            12.verticalSpace,

                            ListView.separated(
                              itemBuilder: (context, index) {
                                final student = students[index];
                                final status = attendanceMap[student.id];

                                return AttendCard(
                                  studentName: student.name,
                                  belt: student.beltLevel,
                                  isAttend: status == "Present",
                                  isAbsent: status == "Absent",
                                  onAttendTap: () => toggleAttend(student),
                                  onAbsentTap: () => toggleAbsent(student),
                                  statusBeltColor: getBeltColor(
                                    student.beltLevel,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  12.verticalSpace,
                              itemCount: students.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                          ],
                        ),
                      ),
                      20.verticalSpace,
                      Center(
                        child: ElevatedButton(
                          onPressed: () => saveAttendance(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.w,
                              vertical: 12.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.save, color: AppColors.card),
                              12.horizontalSpace,
                              Text(
                                'Save Attendance',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.card,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.pushNamed(Routes.showAttendance);
                      },
                      child: const Text("how attindance"),
                    ),
                  ],
                ),
              );
            },
            listener: (BuildContext context, AttendanceState state) {
              if (state is AttendanceSuccessBulk) {
                SnackBarHelper.show(
                  context,
                  'Attendance saved successfully!',
                  type: SnackBarType.success,
                );
                setState(() {
                  attendanceMap.clear();
                  counterPresent = 0;
                  counterAbsent = 0;
                });
              } else if (state is AttendanceFailure) {
                SnackBarHelper.show(
                  context,
                  state.error,
                  type: SnackBarType.error,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
