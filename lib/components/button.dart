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
          fixedSize: const Size(80, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          side: const BorderSide(width: 1.0, color: Colors.white)),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
