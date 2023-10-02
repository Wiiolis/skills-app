import 'dart:convert';

import 'package:demo_app/components/button.dart';
import 'package:demo_app/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../api/api_service.dart';
import '../components/dropdown.dart';
import '../globals.dart';

class NewSupervisor extends StatefulWidget {
  const NewSupervisor({super.key});

  @override
  State<NewSupervisor> createState() => _NewSupervisorState();
}

class _NewSupervisorState extends State<NewSupervisor> {
  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final departmentInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isNameEmpty = false;
  bool _isEmailEmpty = false;
  bool _isDepartmentEmpty = false;

  Future _saveSupervisor() async {
    _isNameEmpty = nameInputController.text.isEmpty;
    _isEmailEmpty = emailInputController.text.isEmpty;
    _isDepartmentEmpty = departmentInputController.text.isEmpty;

    if (_isNameEmpty ||
        _isEmailEmpty ||
        _isDepartmentEmpty ||
        !RegExp(r'\S+@\S+\.\S+').hasMatch(emailInputController.text)) {
      setState(() {});
      return; // Don't proceed if any field is empty
    }

    var body = jsonEncode({
      "full_name": nameInputController.text,
      "email": emailInputController.text,
      "department": departmentInputController.text,
    });

    return ApiService().saveInstructor(body).then((value) => {
          Navigator.pop(context, value),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
            child: Column(
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Row(
                        children: [
                          Icon(Icons.chevron_left_outlined,
                              color: AppColors.primaryColor, size: 20),
                          Text(
                            'Back',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                    const Center(
                        child: Text(
                      'Add New Supervisor',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                      'Here you can add a new supervisor who is not in the list. Our team will be reviewing your request.'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          'Supervisor Details',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyTextField(
                          controller: nameInputController,
                          hintText: 'Add supervisor name and surname',
                          label: 'Name Surname',
                          obscureText: false,
                          required: true,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyTextField(
                          controller: emailInputController,
                          hintText: 'Add email',
                          label: 'Email',
                          email: true,
                          required: true,
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyTextField(
                          controller: departmentInputController,
                          hintText: 'e.g. Cardiology',
                          label: 'Department',
                          obscureText: false,
                          required: true,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Button(
                            text: 'Submit',
                            onClick: () {
                              if (_formKey.currentState!.validate()) {
                                return _saveSupervisor();
                              }
                            },
                            theme: 'dark',
                            radius: 5)
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
        ));
  }
}
