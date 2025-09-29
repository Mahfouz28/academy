import 'package:academy/core/data/repo/supanase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());
  final supabaserepo = SupanaseRepo();
  // get all  students
  Future<void> getAllStudents() async {
    emit(GetAllStudentsLoading());
    try {
      final respose = await supabaserepo.getStudents();
      final students = respose;
      final attendanceResponse = await supabaserepo.getAttendance();
      final attendance = attendanceResponse;
      emit(GetAllStudentsSuccess(students, attendance));
    } catch (e) {
      emit(GetAllStudentsFailure(e.toString()));
    }
  }

  // get attendance students
}
