import 'package:academy/core/router/routs.dart';
import 'package:academy/features/attendance/ui/pages/attendance.dart';
import 'package:academy/features/students/logic/cubit/student_cubit.dart';
import 'package:academy/features/students/ui/page/add_student.dart';
import 'package:academy/features/students/ui/page/students.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.addStudent:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => StudentCubit(),
            child: const AddStudent(),
          ),
        );

      case Routes.attendance:
        return MaterialPageRoute(builder: (_) => const Attendance());

      case Routes.students:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => StudentCubit()..getStudents(),
            child: const Students(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Text('Error'));
    }
  }
}
