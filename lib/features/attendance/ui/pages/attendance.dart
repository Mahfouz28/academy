import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/app_bar.dart';
import 'package:academy/core/widgets/app_card.dart';
import 'package:academy/core/widgets/drawer.dart';
import 'package:academy/features/attendance/ui/widgets/attend_card.dart';
import 'package:academy/features/attendance/ui/widgets/attendancr_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  int counterPresent = 0;
  int counterAbsent = 0;

  List<StudentAttendance> students = List.generate(
    2,
    (index) => StudentAttendance(name: "Student $index", belt: "Blue level"),
  );

  void toggleAttend(int index) {
    setState(() {
      final student = students[index];

      if (student.isAbsent) counterAbsent--;

      if (!student.isAttend) {
        student.isAttend = true;
        student.isAbsent = false;
        counterPresent++;
      }
    });
  }

  void toggleAbsent(int index) {
    setState(() {
      final student = students[index];

      if (student.isAttend) counterPresent--;

      if (!student.isAbsent) {
        student.isAbsent = true;
        student.isAttend = false;
        counterAbsent++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AcademyAppBar(),
      drawer: AcademyDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: Padding(
            padding: EdgeInsets.all(22.0.r),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
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
                          child: Text(
                            'Students Attendance',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.chart1,
                            ),
                          ),
                        ),
                        Divider(color: AppColors.border),
                        12.verticalSpace,

                        // ✅ بناء القائمة
                        ListView.separated(
                          itemBuilder: (context, index) {
                            final student = students[index];
                            return AttendCard(
                              studentName: student.name,
                              belt: student.belt,
                              isAttend: student.isAttend,
                              isAbsent: student.isAbsent,
                              onAttendTap: () => toggleAttend(index),
                              onAbsentTap: () => toggleAbsent(index),
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
                    child: SizedBox(
                      width: 235.w,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle submit attendance logic here
                          print('Attendance Submitted!');
                          print('Present: $counterPresent');
                          print('Absent: $counterAbsent');
                        },
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StudentAttendance {
  final String name;
  final String belt;
  bool isAttend;
  bool isAbsent;

  StudentAttendance({
    required this.name,
    required this.belt,
    this.isAttend = false,
    this.isAbsent = false,
  });
}
