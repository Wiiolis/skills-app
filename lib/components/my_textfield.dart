import 'package:flutter/material.dart';

import '../globals.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final String? label;
  final bool email;
  final bool required;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.label,
    this.email = false,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: label != null
              ? Text(label!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 12))
              : null,
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: (value) {
              // Check if this field is empty
              if ((value == null || value.isEmpty) && required == true) {
                return 'This field is required';
              }

              // using regular expression
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!) && email == true) {
                return "Please enter a valid email address";
              }

              // the email is valid
              return null;
            },
            expands: true,
            maxLines: null,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.placeholderColor,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: AppColors.primaryLightColor),
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.placeholderColor,
              ),
            ),
            mouseCursor: MaterialStateMouseCursor.clickable,
          ),
        )
      ],
    );
  }
}
