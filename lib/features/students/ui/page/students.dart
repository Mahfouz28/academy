import 'package:academy/core/themes/app_color.dart';
import 'package:academy/features/students/ui/widgets/add_student.dart';
import 'package:academy/features/students/ui/widgets/searche_bar.dart';
import 'package:academy/features/students/ui/widgets/show_students.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Students extends StatelessWidget {
  const Students({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Academy',
          style: TextStyle(
            fontSize: 25,
            color: AppColors.accent,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      drawer: const Drawer(child: Column(children: [

            
          ],
          
        )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(28.r),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [AddStudent(), SearcheBar(), ShowStudents()],
            ),
          ),
        ),
      ),
    );
  }
}
