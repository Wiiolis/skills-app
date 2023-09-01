import 'package:flutter/material.dart';

import '../globals.dart';

class NewSupervisor extends StatefulWidget {
  const NewSupervisor({super.key});

  @override
  State<NewSupervisor> createState() => _NewSupervisorState();
}

class _NewSupervisorState extends State<NewSupervisor> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(20, 25, 20, 15),
        )));
  }
}
