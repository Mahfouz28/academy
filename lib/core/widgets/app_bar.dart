import 'package:academy/core/themes/app_color.dart';
import 'package:flutter/material.dart';

class AcademyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const AcademyAppBar({super.key, this.title = 'Academy', this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Academy',
        style: TextStyle(
          fontSize: 25,
          color: AppColors.accent,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
