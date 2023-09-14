// ignore_for_file: camel_case_types

import 'package:demo_app/globals.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  String theme = 'light';
  double radius = 15;
  double buttonHeight = 40;
  double buttonWidth = double.maxFinite;
  final Function() onClick;
  final String? icon;

  Color getBorderColor() {
    if (theme == 'light') {
      return Colors.white;
    } else if (theme == 'dark') {
      return AppColors.primaryColor;
    } else if (theme == 'transparent-dark') {
      return AppColors.primaryColor;
    } else if (theme == 'white') {
      return Colors.white;
    } else {
      return Colors.white;
    }
  }

  Color getBackgroundColor() {
    if (theme == 'light') {
      return Colors.transparent;
    } else if (theme == 'dark') {
      return AppColors.primaryColor;
    } else if (theme == 'transparent-dark') {
      return Colors.transparent;
    } else if (theme == 'white') {
      return Colors.white;
    } else {
      return AppColors.primaryColor;
    }
  }

  Color getTextColor() {
    if (theme == 'light') {
      return Colors.white;
    } else if (theme == 'dark') {
      return Colors.white;
    } else if (theme == 'transparent-dark') {
      return AppColors.primaryColor;
    } else if (theme == 'white') {
      return AppColors.primaryColor;
    } else {
      return Colors.white;
    }
  }

  Button(
      {super.key,
      required this.text,
      required this.onClick,
      required this.theme,
      required this.radius,
      this.buttonHeight = 40,
      this.buttonWidth = double.maxFinite,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onClick(),
      style: OutlinedButton.styleFrom(
        backgroundColor: getBackgroundColor(),
        fixedSize: Size(buttonWidth, buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        side: BorderSide(
          width: 1.0,
          color: getBorderColor(),
        ),
      ),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        if (icon != null)
          Icon(
            Icons.check,
            size: 15,
            color: getTextColor(),
          ),
        if (icon != null) const SizedBox(width: 3),
        Text(text, style: TextStyle(color: getTextColor()))
      ]),
    );
  }
}
