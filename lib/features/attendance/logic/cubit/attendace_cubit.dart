import 'package:academy/features/students/data/models/student_model.dart';
import 'package:bloc/bloc.dart';
import 'package:academy/core/data/repo/supanase_repo.dart';
part 'attendace_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());

  final SupanaseRepo supabaseRepo = SupanaseRepo();
  // get Student
  Future<void> getStudents() async {
    emit(GetAttendanceLoading());
    try {
      final students = await supabaseRepo.getStudents();
      emit(GetAttendanceSuccess(students: students));
    } catch (e) {
      emit(GetAttendanceFailure(error: e.toString()));
    }
  }

  Future<void> insertAttendance({
    required String studentId,
    required DateTime date,
    required String status,
  }) async {
    // emit(AttendanceLoading());
    try {
      await supabaseRepo.insertAttendance(
        studentId: studentId,
        date: date,
        status: status,
      );
      // emit(AttendanceSuccess(studentId: studentId, status: status));
    } catch (e) {
      emit(AttendanceFailure(error: e.toString()));
    }
  }

  Future<void> saveAllAttendance({
    required DateTime date,
    required Map<String, String> studentStatusMap,
  }) async {
    emit(AttendanceLoading());
    try {
      for (final entry in studentStatusMap.entries) {
        await supabaseRepo.insertAttendance(
          studentId: entry.key,
          date: date,
          status: entry.value,
        );
      }
      emit(AttendanceSuccessBulk());
    } catch (e) {
      emit(AttendanceFailure(error: e.toString()));
    }
  }

  //
  Future<void> getAttendanceByDate(String date) async {
    emit(GetAttendanceByDateLoading());
    try {
      final records = await supabaseRepo.getAttendanceByDate(date);
      emit(GetAttendanceByDateSuccess(attendanceRecords: records));
    } catch (e) {
      emit(GetAttendanceByDateFailure(error: e.toString()));
    }
  }

  // get all student
  Future<void> getAllStudents() async {
    emit(GetAllStudentsLoading());
    try {
      final students = await supabaseRepo.getStudents();
      emit(GetAllStudentsSuccess(students: students));
    } catch (e) {
      emit(GetAllStudentsFailure(error: e.toString()));
    }
  }
}
