import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../globals.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? label;
  final bool email;
  final bool required;
  final icon;
  final prefixIcon;
  final autofill;
  final ValueChanged<String>? onChanged;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.label,
    this.email = false,
    this.required = true,
    this.icon,
    this.prefixIcon,
    // test and potentionally remove !!
    this.autofill,
    this.onChanged,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  // test and potentionally remove !!
  List<String> _getAutofillHints() {
    if (widget.autofill == 'email') {
      return [AutofillHints.email];
    } else if (widget.autofill == 'password') {
      return [AutofillHints.password];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: widget.label != null
              ? Text(widget.label!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 12))
              : null,
        ),
        SizedBox(
          height: widget.label != null ? 10 : 0,
        ),
        TextFormField(
          // test and potentionally remove !!
          autofillHints: _getAutofillHints(),
          onChanged: widget.onChanged,
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
          maxLines: 1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            suffixIcon: widget.icon,
            prefixIcon: widget.prefixIcon,
            suffixIconConstraints: const BoxConstraints(minWidth: 55),
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
