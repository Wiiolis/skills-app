// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function() onClick;

  Button({required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onClick(),
      style: OutlinedButton.styleFrom(
          fixedSize: const Size(80, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          side: const BorderSide(width: 1.0, color: Colors.white)),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
