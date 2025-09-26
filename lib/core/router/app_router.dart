import 'package:academy/core/router/routs.dart';
import 'package:academy/features/students/ui/page/students.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.students:
        return MaterialPageRoute(builder: (_) => const Students());
      default:
        return MaterialPageRoute(builder: (_) => const Text('No Route Found'));
    }
  }
}
