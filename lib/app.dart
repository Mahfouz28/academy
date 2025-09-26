import 'package:academy/core/router/app_router.dart';
import 'package:academy/core/themes/app_themes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      onGenerateRoute: AppRouter().generateRoute,
      initialRoute: '/students',
    );
  }
}
