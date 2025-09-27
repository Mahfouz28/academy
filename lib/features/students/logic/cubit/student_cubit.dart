import 'package:academy/core/data/repo/supanase_repo.dart';
import 'package:academy/features/students/data/models/student_model.dart';
import 'package:bloc/bloc.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(StudentInitial());

  final SupanaseRepo repo = SupanaseRepo();
  // to add new student
  Future<void> addStudent(
    String name,
    String phone,
    int age,
    String beltLevel,
    String subscriptionStatus,
  ) async {
    emit(AddLoading());
    try {
      final result = await repo.insertStudent(
        name: name,
        phone: phone,
        age: age,
        beltLevel: beltLevel,
        subscriptionStatus: subscriptionStatus,
      );

      if (result == null) {
        emit(AddFailure("Failed to insert student"));
      } else {
        emit(Addsuccess(result));
      }
    } catch (e) {
      emit(AddFailure(e.toString()));
    }
  }

  // to get all student
  void getStudents() async {
    emit(GetStudentsLoading());
    try {
      final students = await repo.getStudents();
      emit(GetStudentsSuccess(students));
    } catch (e) {
      emit(GetStudentsFailure(e.toString()));
    }
  }

  // to delete student
  void deleteStudent(String id) async {
    emit(DeleteStudentLoading());
    try {
      await repo.deleteStudent(id);
      emit(DeleteStudentSuccess());
    } catch (e) {
      emit(DeleteStudentFailure(e.toString()));
    }
  }

  // to update student
  void updateStudent(Student student) async {
    emit(UpdateStudentLoading());
    try {
      await repo.updateStudent(student);
      emit(UpdateStudentSuccess());
    } catch (e) {
      emit(UpdateStudentFailure(e.toString()));
    }
  }
}
