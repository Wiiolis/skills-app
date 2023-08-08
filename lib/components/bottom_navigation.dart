import 'package:flutter/material.dart';

import '../globals.dart';

// ignore: camel_case_types
class bottomNavigation extends StatelessWidget {
  const bottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.primaryColor,
      fixedColor: Colors.white,
      unselectedItemColor: Colors.white,
      unselectedLabelStyle: const TextStyle(color: Colors.white),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: svgPicture.asset("assets/images/Skills.svg"),
          label: 'Skills',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.file_copy_outlined,
            color: Colors.white,
          ),
          label: 'Documents',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          label: 'Info',
        ),
      ],
    );
  }
}
