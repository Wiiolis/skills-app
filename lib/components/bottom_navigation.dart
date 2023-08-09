import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../globals.dart';

// ignore: camel_case_types
class bottomNavigation extends StatefulWidget {
  const bottomNavigation({super.key});

  @override
  State<bottomNavigation> createState() => _bottomNavigationState();
}

class _bottomNavigationState extends State<bottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    print(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
      backgroundColor: AppColors.primaryColor,
      fixedColor: Colors.white,
      unselectedItemColor: Colors.white,
      unselectedLabelStyle: const TextStyle(color: Colors.white),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset('assets/images/Skills-filled.svg',
              color: Colors.white),
          icon:
              SvgPicture.asset('assets/images/Skills.svg', color: Colors.white),
          label: 'Skills',
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset('assets/images/Documents-filled.svg',
              color: Colors.white),
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
