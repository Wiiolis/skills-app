// ignore_for_file: camel_case_types

import 'package:demo_app/globals.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  String theme = 'light';
  String radius = 'semiround';
  double? height;
  double? width;
  final Function() onClick;

  Size getButtonSize() {
    if (width != null && height! != null) {
      return Size(width!, height!);
    } else if (height != null) {
      return Size(80, height!);
    } else if (width != null) {
      return Size(width!, 40);
    } else {
      return Size(80, 40);
    }
  }

  Color getBorderColor() {
    if (theme == 'light') {
      return Colors.white;
    } else if (theme == 'dark') {
      return AppColors.primaryColor;
    } else if (theme == 'transparent-dark') {
      return AppColors.primaryColor;
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
    } else {
      return Colors.white;
    }
  }

  BorderRadius getBorderRadius() {
    if (radius == 'round') {
      return BorderRadius.circular(18);
    } else if (theme == 'semiround') {
      return BorderRadius.circular(9);
    } else {
      return BorderRadius.circular(9);
    }
  }

  Button(
      {super.key,
      required this.text,
      required this.onClick,
      required this.theme,
      required this.radius,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onClick(),
      style: OutlinedButton.styleFrom(
        backgroundColor: getBackgroundColor(),
        fixedSize: getButtonSize(),
        shape: RoundedRectangleBorder(
          borderRadius: getBorderRadius(),
        ),
        side: BorderSide(
          width: 1.0,
          color: getBorderColor(),
        ),
      ),
      child: Text(text, style: TextStyle(color: getTextColor())),
    );
  }
}
