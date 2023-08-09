import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../globals.dart';

typedef navCallback = void Function(int selectedValue);

class BottomNavigation extends StatefulWidget {
  final navCallback callback; // Add callback property

  const BottomNavigation({
    Key? key,
    required this.callback, // Initialize callback in the constructor
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
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
      selectedFontSize: 12,
      fixedColor: Colors.white,
      unselectedItemColor: Colors.white,
      unselectedLabelStyle: const TextStyle(color: Colors.white),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          activeIcon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: SvgPicture.asset('assets/images/Skills-filled.svg',
                color: Colors.white),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: SvgPicture.asset('assets/images/Skills.svg',
                color: Colors.white),
          ),
          label: 'Skills',
        ),
        BottomNavigationBarItem(
          activeIcon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: SvgPicture.asset('assets/images/Documents-filled.svg',
                color: Colors.white),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: SvgPicture.asset('assets/images/Documents.svg',
                color: Colors.white),
          ),
          label: 'Documents',
        ),
        BottomNavigationBarItem(
          activeIcon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: SvgPicture.asset('assets/images/info-filled.svg',
                color: Colors.white),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child:
                SvgPicture.asset('assets/images/info.svg', color: Colors.white),
          ),
          label: 'Info',
        ),
      ],
    );
  }
}
