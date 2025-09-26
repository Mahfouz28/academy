import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/custom_action_button.dart';
import 'package:academy/core/widgets/status_badge.dart';
import 'package:academy/features/students/ui/widgets/student_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowStudents extends StatelessWidget {
  const ShowStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.h),

      width: double.infinity,

      decoration: BoxDecoration(
        color: AppColors.accentForeground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border, width: 2),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 27.h),
            child: Align(
              alignment: AlignmentGeometry.topLeft,
              child: Text(
                'Students List(6)',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.chart1,
                ),
              ),
            ),
          ),

          Divider(color: AppColors.border, thickness: 2),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return StudentCard(
                name: "Mahmoud",
                age: 20,
                phone: "01272210717",
                badges: [
                  StatusBadge(
                    text: "Blue Belt",
                    backgroundColor: Colors.blue.withOpacity(.3),
                    borderColor: Colors.blue,
                    textColor: Colors.blue.shade200,
                  ),
                  StatusBadge(
                    text: "Active",
                    backgroundColor: Colors.greenAccent.withOpacity(.3),
                    borderColor: Colors.green,
                    textColor: Colors.green.shade200,
                  ),
                ],
                editButton: CustomActionButton(
                  width: 180,
                  backgroundColor: const Color(0xFF1F2937),
                  borderColor: const Color(0xFF374151),
                  textColor: Colors.white,
                  icon: Icons.edit,
                  text: 'Edit',
                  onPressed: () => print("Edit clicked!"),
                ),
                deleteButton: CustomActionButton(
                  width: 50,
                  backgroundColor: const Color(0xFF1F2937),
                  borderColor: AppColors.destructive,
                  textColor: Colors.red,
                  icon: Icons.delete,
                  text: null,
                  onPressed: () => print("Delete clicked!"),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox.shrink();
            },
            itemCount: 6,
          ),
        ],
      ),
    );
  }
}
