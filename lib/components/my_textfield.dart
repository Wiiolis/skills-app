import 'package:flutter/material.dart';

import '../globals.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
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
    this.required = true,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: widget.label != null
              ? Text(widget.label!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 12))
              : null,
        ),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          validator: (value) {
            if ((value == null || value.isEmpty) && widget.required == true) {
              return 'This field is required';
            }

            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!) &&
                widget.email == true) {
              return "Please enter a valid email address";
            }

            // the email is valid
            return null;
          },
          expands: false,
          maxLines: null,
          decoration: InputDecoration(
            errorMaxLines: 1,
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
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Color.fromARGB(255, 186, 119, 119)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Color.fromARGB(255, 186, 119, 119)),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: AppColors.placeholderColor,
            ),
          ),
          mouseCursor: MaterialStateMouseCursor.clickable,
        )
      ],
    );
  }
}
