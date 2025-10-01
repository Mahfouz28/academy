import 'package:academy/core/router/routs.dart';
import 'package:academy/features/attendance/logic/cubit/attendace_cubit.dart';
import 'package:academy/features/attendance/ui/pages/show_attendace.dart';
import 'package:academy/features/attendance/ui/pages/take_attendace.dart';
import 'package:academy/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:academy/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:academy/features/students/logic/cubit/student_cubit.dart';
import 'package:academy/features/students/ui/page/add_student.dart';
import 'package:academy/features/students/ui/page/students.dart';
import 'package:academy/features/subscriptions/presentation/cubit/subscriptions_cubit.dart';
import 'package:academy/features/subscriptions/presentation/pages/subscriptions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.addStudent:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => StudentCubit(),
            child: AddStudent(),
          ),
        );
      case Routes.showAttendance:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AttendanceCubit(),
            child: AttendanceScreen(),
          ),
        );

      case Routes.attendance:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AttendanceCubit(),
            child: Attendance(),
          ),
        );

      case Routes.subscriptions:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SubscriptionsCubit()..getAllStudents(),
            child: SubscriptionsPage(),
          ),
        );

      case Routes.dashboard:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => DashboardCubit()..getAllStudents(),

            child: DashboardPage(),
          ),
        );

      case Routes.students:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => StudentCubit()..getStudents(),
            child: Students(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => DashboardCubit()..getAllStudents(),

            child: DashboardPage(),
          ),
        );
    }
  }
}
