import 'package:flutter/material.dart';

class button extends StatelessWidget {
  final String text;
  final Function() onClick;

  button({required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onClick(),
      style: OutlinedButton.styleFrom(
          fixedSize: const Size(90, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          side: const BorderSide(width: 1.0, color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
