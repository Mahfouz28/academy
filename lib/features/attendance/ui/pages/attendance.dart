import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/app_bar.dart';
import 'package:academy/core/widgets/app_card.dart';
import 'package:academy/core/widgets/drawer.dart';
import 'package:academy/core/widgets/status_badge.dart';

import 'package:academy/features/attendance/ui/widgets/attendancr_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Attendance extends StatelessWidget {
  const Attendance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AcademyAppBar(),
      drawer: AcademyDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: Padding(
            padding: EdgeInsets.all(22.0.r),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AttendancrHeader(),
                  AppCard(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Students Attendance',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.chart1,
                            ),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
