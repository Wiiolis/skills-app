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
  final displayBorder;

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
    this.displayBorder = true,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final focusNode = FocusNode();
  Color color = AppColors.lightGrayColor;
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
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  focusColor() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          color = AppColors.placeholderColor;
        });
      } else {
        setState(() {
          color = AppColors.lightGrayColor;
        });
      }
    });
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      // test and potentionally remove !!
      autofillHints: _getAutofillHints(),
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: widget.obscureText,
      validator: (value) {
        if ((value == null || value.isEmpty) && widget.required == true) {
          return 'This field is required';
        }

        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!) && widget.email == true) {
          return "Please enter a valid email address";
        }

        // the email is valid
        return null;
      },
      expands: false,
      maxLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        suffixIcon: widget.icon,
        prefixIcon: widget.prefixIcon,
        suffixIconConstraints: const BoxConstraints(minWidth: 55),
        errorMaxLines: 1,
        enabledBorder: widget.displayBorder
            ? const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.placeholderColor,
                ),
              )
            : const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide.none),
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
        hintStyle: TextStyle(color: focusColor()),
      ),
      mouseCursor: MaterialStateMouseCursor.clickable,
    );
  }
}
