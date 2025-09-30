part of 'attendace_cubit.dart';

abstract class AttendanceState {}

/// --- Initial ---
class AttendanceInitial extends AttendanceState {}

/// --- Insert Attendance ---
class AttendanceLoading extends AttendanceState {}

class AttendanceSuccess extends AttendanceState {
  final String studentId;
  final String status;

  AttendanceSuccess({required this.studentId, required this.status});
}

class AttendanceSuccessBulk extends AttendanceState {}

class AttendanceFailure extends AttendanceState {
  final String error;
  AttendanceFailure({required this.error});
}

/// --- Get Students ---
class GetAttendanceLoading extends AttendanceState {}

class GetAttendanceSuccess extends AttendanceState {
  final List<Student> students;
  GetAttendanceSuccess({required this.students});
}

class GetAttendanceFailure extends AttendanceState {
  final String error;
  GetAttendanceFailure({required this.error});
}

class GetAttendanceByDateLoading extends AttendanceState {}

class GetAttendanceByDateSuccess extends AttendanceState {
  final List<Map<String, dynamic>> attendanceRecords;

  GetAttendanceByDateSuccess({required this.attendanceRecords});
}

class GetAttendanceByDateFailure extends AttendanceState {
  final String error;

  GetAttendanceByDateFailure({required this.error});
}

class GetAllStudentsLoading extends AttendanceState {}

class GetAllStudentsSuccess extends AttendanceState {
  final List<Student> students;

  GetAllStudentsSuccess({required this.students});
}

class GetAllStudentsFailure extends AttendanceState {
  final String error;

  GetAllStudentsFailure({required this.error});
}
