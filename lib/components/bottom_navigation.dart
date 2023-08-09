import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../globals.dart';

typedef navCallback = void Function(int selectedValue);

class bottomNavigation extends StatefulWidget {
  final navCallback callback; // Add callback property

  bottomNavigation({
    Key? key,
    required this.callback, // Initialize callback in the constructor
  }) : super(key: key);

  @override
  State<bottomNavigation> createState() => _bottomNavigationState();
}

class _bottomNavigationState extends State<bottomNavigation> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    widget.callback(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: _onItemTapped,
      currentIndex: selectedIndex,
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
