import 'package:demo_app/components/bottom_navigation.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class SkillDetail extends StatefulWidget {
  const SkillDetail({super.key});

  @override
  State<SkillDetail> createState() => _SkillDetailState();
}

class _SkillDetailState extends State<SkillDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const bottomNavigation(),
      body: Column(
        children: [
          Row(
            children: [
              BackButton(
                  onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()),
                      ))
            ],
          )
        ],
      ),
    );
  }
}
