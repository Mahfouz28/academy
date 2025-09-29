class StudentAttendanceModel {
  final String studentId;
  final String name;
  final String belt;
  bool isAttend;
  bool isAbsent;

  StudentAttendanceModel({
    required this.studentId,
    required this.name,
    required this.belt,
    this.isAttend = false,
    this.isAbsent = false,
  });
}
