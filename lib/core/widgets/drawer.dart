import 'package:academy/core/helpers/navigat.dart';
import 'package:academy/core/router/routs.dart';
import 'package:academy/core/themes/app_color.dart';
import 'package:flutter/material.dart';

class AcademyDrawer extends StatelessWidget {
  const AcademyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: AppColors.card),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Academy Menu',
                  style: TextStyle(color: AppColors.accent, fontSize: 24),
                ),
                SizedBox(height: 8),
                Text(
                  'Manage your academy',
                  style: TextStyle(
                    color: AppColors.mutedForeground,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.people_alt_outlined,
              color: AppColors.foreground,
            ),
            title: const Text(
              'Students',
              style: TextStyle(color: AppColors.foreground),
            ),
            onTap: () {
              context.pushNamed(Routes.students);
              context.pushNamed(Routes.students);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.calendar_today,
              color: AppColors.foreground,
            ),
            title: const Text(
              'Attendance',
              style: TextStyle(color: AppColors.foreground),
            ),
            onTap: () {
              Navigator.pop(context);

              context.pushNamed(Routes.attendance);
            },
          ),
        ],
      ),
    );
  }
}
