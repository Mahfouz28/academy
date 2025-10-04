import 'package:academy/core/themes/app_color.dart';
import 'package:academy/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearcheBar extends StatelessWidget {
  const SearcheBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 27.h),
      height: 110.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.accentForeground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border, width: 2),
      ),
      child: TextFormField(
        onChanged: (value) {
          if (value.isEmpty) {
            context.read<DashboardCubit>().getAllStudents();
          } else {
            context.read<DashboardCubit>().searchStudents(value);
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: AppColors.accent),
          isDense: false,
          contentPadding: EdgeInsets.only(top: 12.r),
          hintText: 'Search for student by name or ID',

          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: AppColors.accent),
          ),
        ),
      ),
    );
  }
}
