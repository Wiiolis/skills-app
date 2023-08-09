import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          icon:
              SvgPicture.asset('assets/images/Skills.svg', color: Colors.white),
          label: 'Skills',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/images/Documents.svg',
              color: Colors.white),
          label: 'Documents',
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset('assets/images/info-filled.svg',
              color: Colors.white),
          icon: SvgPicture.asset('assets/images/info.svg', color: Colors.white),
          label: 'Info',
        ),
      ],
    );
  }
}
