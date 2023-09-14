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

  String? selectedHospital;
  List<Map<String, String>> hospitals = [
    {'name': 'Hospital One', 'level': 'assistant'},
    {'name': 'Hospital Two', 'level': 'observer'},
  ];

  Future _saveSupervisor() async {
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
        body: SingleChildScrollView(
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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

                      // NAME
                      Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 15, 0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Name Surname',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Required',
                                    style: TextStyle(
                                        color: AppColors.lightGrayColor,
                                        fontSize: 10),
                                  )
                                ]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          MyTextField(
                            controller: nameInputController,
                            hintText: 'Add supervisor name and surname',
                            obscureText: false,
                          ),
                        ],
                      ),

                      // EMAIL
                      Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 15, 0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Required',
                                    style: TextStyle(
                                        color: AppColors.lightGrayColor,
                                        fontSize: 10),
                                  )
                                ]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          MyTextField(
                            controller: emailInputController,
                            hintText: 'Add email',
                            email: true,
                            obscureText: false,
                          ),
                        ],
                      ),

                      //HOSPITAL
                      Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 15, 0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Hospital',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Required',
                                    style: TextStyle(
                                        color: AppColors.lightGrayColor,
                                        fontSize: 10),
                                  )
                                ]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                              height: 50,
                              child: Dropdown(
                                  dropdownItems: hospitals,
                                  callback: (selectedItem) {
                                    setState(() {
                                      selectedHospital = selectedItem;
                                    });
                                  },
                                  selectedItem: selectedHospital,
                                  valueName: 'name',
                                  theme: 'dark'))
                        ],
                      ),

                      //DEPARTMENT
                      Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 15, 0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Department',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Required',
                                    style: TextStyle(
                                        color: AppColors.lightGrayColor,
                                        fontSize: 10),
                                  )
                                ]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          MyTextField(
                            controller: departmentInputController,
                            hintText: 'e.g. Cardiology',
                            obscureText: false,
                          )
                        ],
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
        )));
  }
}
