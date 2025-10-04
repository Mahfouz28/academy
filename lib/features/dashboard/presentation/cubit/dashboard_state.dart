abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
  // final result;
  // Success(this.result);
}

class DashboardFailure extends DashboardState {
  final String error;
  DashboardFailure(this.error);
}

// get all students
class GetAllStudentsLoading extends DashboardState {}

class GetAllStudentsSuccess extends DashboardState {
  final students;
  final attendance;
  GetAllStudentsSuccess(this.students, this.attendance);
}

class GetAllStudentsFailure extends DashboardState {
  final String error;
  GetAllStudentsFailure(this.error);
}

// get attendance students
class GetAttendanceLoading extends DashboardState {}

class GetAttendanceSuccess extends DashboardState {
  final attendance;
  GetAttendanceSuccess(this.attendance);
}

class GetAttendanceFailure extends DashboardState {
  final String error;
  GetAttendanceFailure(this.error);
}

// serch
class SearchStudentsLoading extends DashboardState {}

class SearchStudentsSuccess extends DashboardState {
  final students;

  SearchStudentsSuccess(this.students);
}

class SearchStudentsFailure extends DashboardState {
  final String error;
  SearchStudentsFailure(this.error);
}
