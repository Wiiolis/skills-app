// ignore_for_file: camel_case_types

import 'package:demo_app/globals.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  String theme = 'light';
  final Function() onClick;

  Button(
      {super.key,
      required this.text,
      required this.onClick,
      required this.theme});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onClick(),
      style: OutlinedButton.styleFrom(
          backgroundColor:
              theme == 'light' ? Colors.transparent : AppColors.primaryColor,
          fixedSize: const Size(80, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          side: BorderSide(
              width: 1.0,
              color: theme == 'light' ? Colors.white : AppColors.primaryColor)),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
