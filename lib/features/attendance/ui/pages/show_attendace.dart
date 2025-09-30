import 'package:academy/core/widgets/app_bar.dart';
import 'package:academy/core/widgets/drawer.dart';
import 'package:academy/features/attendance/logic/cubit/attendace_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    context.read<AttendanceCubit>().getAllStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AcademyAppBar(),
      drawer: AcademyDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(22.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2024, 1, 1),
                    lastDate: DateTime(2030, 12, 31),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                    final formatted = DateFormat(
                      'yyyy-MM-dd',
                    ).format(pickedDate);
                    context.read<AttendanceCubit>().getAttendanceByDate(
                      formatted,
                    );
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  selectedDate == null
                      ? "Select Date"
                      : DateFormat('dd-MM-yyyy').format(selectedDate!),
                ),
              ),
              20.verticalSpace,

              Expanded(
                child: BlocConsumer<AttendanceCubit, AttendanceState>(
                  builder: (context, state) {
                    if (state is GetAttendanceByDateLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetAttendanceByDateFailure) {
                      return Center(child: Text("Error: ${state.error}"));
                    } else if (state is GetAttendanceByDateSuccess) {
                      if (state.attendanceRecords.isEmpty) {
                        return const Center(
                          child: Text("No attendance records for this day."),
                        );
                      }

                      return ListView.separated(
                        itemCount: state.attendanceRecords.length,
                        separatorBuilder: (_, __) => 10.verticalSpace,
                        itemBuilder: (context, index) {
                          final record = state.attendanceRecords[index];

                          final isPresent =
                              record['status']?.toString().toLowerCase() ==
                              "present";

                          final student = record['students'] ?? {};
                          final studentName =
                              student['name']?.toString() ?? 'Unknown';

                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: isPresent
                                  ? Colors.green.withOpacity(0.2)
                                  : Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: isPresent ? Colors.green : Colors.red,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isPresent ? Icons.check_circle : Icons.cancel,
                                  color: isPresent ? Colors.green : Colors.red,
                                ),
                                12.horizontalSpace,
                                Expanded(
                                  child: Text(
                                    studentName,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return const Center(
                      child: Text("Select a date to view attendance."),
                    );
                  },
                  listener: (context, state) {
                    if (state is GetAllStudentsFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Error loading students: ${state.error}",
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
