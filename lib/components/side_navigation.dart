import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../globals.dart';

typedef navCallback = void Function(int selectedValue);

class SideNavigation extends StatefulWidget {
  final navCallback callback;
  final user;

  const SideNavigation({
    Key? key,
    required this.callback,
    required this.user,
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
    return Container(
      decoration: BoxDecoration(color: AppColors.primaryColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: FutureBuilder<dynamic>(
              future: widget.user,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final user = snapshot.data;
                  return user.avatars != null && user.avatars.small != null
                      ? CircleAvatar(
                          radius: 19,
                          backgroundImage: NetworkImage(user.avatars.small),
                        )
                      : const Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 40,
                        );
                }
              },
            ),
          ),
          Expanded(
            child: NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) {
                _onItemTapped(index);
              },
              backgroundColor: AppColors.primaryColor,
              selectedLabelTextStyle: const TextStyle(fontSize: 12),
              unselectedLabelTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 12),
              labelType: NavigationRailLabelType.all,
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
                    child: SvgPicture.asset(
                        'assets/images/Documents-filled.svg',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
