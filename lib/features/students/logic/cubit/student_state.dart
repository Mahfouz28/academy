part of 'student_cubit.dart';

sealed class StudentState {}

final class StudentInitial extends StudentState {}

// add new student state
final class AddLoading extends StudentState {}

final class Addsuccess extends StudentState {
  Addsuccess(String result);
}

final class AddFailure extends StudentState {
  final String error;

  AddFailure(this.error);
}
// get student state

final class GetStudentsLoading extends StudentState {}

final class GetStudentsSuccess extends StudentState {
  final List<Student> students;

  GetStudentsSuccess(this.students);
}

final class GetStudentsFailure extends StudentState {
  final String error;

  GetStudentsFailure(this.error);
}

// delete student state
final class DeleteStudentLoading extends StudentState {}

final class DeleteStudentSuccess extends StudentState {}

final class DeleteStudentFailure extends StudentState {
  final String error;

  DeleteStudentFailure(this.error);
}

// update student state
final class UpdateStudentLoading extends StudentState {}

final class UpdateStudentSuccess extends StudentState {}

final class UpdateStudentFailure extends StudentState {
  final String error;

  UpdateStudentFailure(this.error);
}
