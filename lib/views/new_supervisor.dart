import 'package:demo_app/components/button.dart';
import 'package:demo_app/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  String? selectedHospital;
  List<Map<String, String>> hospitals = [
    {'name': 'Hospital One', 'level': 'assistant'},
    {'name': 'Hospital Two', 'level': 'observer'},
  ];

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
                    onTap: () => context.goNamed("home"),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        SizedBox(
                          height: 50,
                          child: MyTextField(
                            controller: nameInputController,
                            hintText: 'Add supervisor name and surname',
                            obscureText: false,
                          ),
                        )
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        SizedBox(
                          height: 50,
                          child: MyTextField(
                            controller: emailInputController,
                            hintText: 'Add supervisor email',
                            obscureText: false,
                          ),
                        )
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Hospital',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Select Hospital',
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
                            child: Dropdown2(
                              dropdownItems: hospitals,
                              callback: (selectedItem) {
                                setState(() {
                                  selectedHospital = selectedItem;
                                });
                              },
                              selectedItem: selectedHospital,
                              valueName: 'name',
                            ))
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        SizedBox(
                          height: 50,
                          child: MyTextField(
                            controller: departmentInputController,
                            hintText: 'e.g. Cardiology',
                            obscureText: false,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Button(
                        text: 'Submit',
                        onClick: () {},
                        theme: 'dark',
                        radius: 5)
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
