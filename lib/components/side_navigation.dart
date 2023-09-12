import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

typedef navCallback = void Function(int selectedValue);

class SideNavigation extends StatefulWidget {
  final navCallback callback;

  const SideNavigation({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  State<SideNavigation> createState() => _SideNavigationState();
}

class _SideNavigationState extends State<SideNavigation> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    widget.callback(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          _onItemTapped(index);
        },
        labelType: NavigationRailLabelType.selected,
        destinations: <NavigationRailDestination>[
          NavigationRailDestination(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: SvgPicture.asset('assets/images/Skills.svg',
                  color: Colors.white),
            ),
            selectedIcon: Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: SvgPicture.asset('assets/images/Skills-filled.svg',
                  color: Colors.white),
            ),
            label: const Text('Home'),
          ),
          NavigationRailDestination(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: SvgPicture.asset('assets/images/Documents.svg',
                  color: Colors.white),
            ),
            selectedIcon: Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: SvgPicture.asset('assets/images/Documents-filled.svg',
                  color: Colors.white),
            ),
            label: const Text('Documents'),
          ),
          NavigationRailDestination(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: SvgPicture.asset('assets/images/Info.svg',
                  color: Colors.white),
            ),
            selectedIcon: Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: SvgPicture.asset('assets/images/Info-filled.svg',
                  color: Colors.white),
            ),
            label: const Text('Info'),
          ),
        ]);
  }
}
