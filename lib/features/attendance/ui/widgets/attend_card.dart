import 'package:academy/core/themes/app_color.dart';
import 'package:academy/core/widgets/status_badge.dart';
import 'package:academy/features/attendance/ui/widgets/attendance_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendCard extends StatelessWidget {
  final String studentName;
  final String belt;
  final bool isAttend;
  final bool isAbsent;
  final VoidCallback? onAttendTap;
  final VoidCallback? onAbsentTap;
  final Color statusBeltColor;

  const AttendCard({
    super.key,
    required this.studentName,
    required this.belt,
    this.isAttend = false,
    this.isAbsent = false,
    this.onAttendTap,
    this.onAbsentTap,
    required this.statusBeltColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isAttend
            ? Colors.green.withOpacity(0.1)
            : isAbsent
            ? Colors.red.withOpacity(0.1)
            : AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 16.r),
        child: Row(
          children: [
            /// اسم الطالب + الحزام
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    studentName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  12.verticalSpace,
                  StatusBadge(
                    backgroundColor: statusBeltColor.withOpacity(.3),
                    borderColor: statusBeltColor,
                    textColor: Colors.white,
                    text: belt,
                  ),
                ],
              ),
            ),

            12.horizontalSpace,

            /// أزرار الحضور والغياب
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AttendanceButton(
                  text: "Present",
                  icon: Icons.check,
                  backgroundColor: isAttend
                      ? Colors.green.withOpacity(.6)
                      : Colors.green.withOpacity(.1),
                  borderColor: Colors.green.withOpacity(.3),
                  textColor: Colors.white,
                  onTap: onAttendTap,
                ),
                12.verticalSpace,
                AttendanceButton(
                  text: "Absent",
                  icon: Icons.close,
                  backgroundColor: isAbsent
                      ? Colors.red.withOpacity(.6)
                      : Colors.red.withOpacity(.1),
                  borderColor: Colors.red.withOpacity(.3),
                  textColor: Colors.white,
                  onTap: onAbsentTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
