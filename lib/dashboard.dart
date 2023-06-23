import 'package:flutter/material.dart';
import 'package:demo_app/components/skill_card_list.dart';
import 'package:demo_app/components/top_widget_profile.dart';

import 'globals.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_outlined),
            label: 'Skills',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy_outlined),
            label: 'Documents',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.05, 0.15, 0.7, 0.9],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              AppColors.primaryColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor
            ],
          ),
        ),
        child: const Column(
          children: [
            TopWidgetProfile(),
            SkillCardList(),
          ],
        ),
      ),
    );
  }
}
