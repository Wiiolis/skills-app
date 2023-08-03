import 'package:demo_app/components/bottom_navigation.dart';
import 'package:demo_app/components/button.dart';
import 'package:demo_app/components/dropdown.dart';
import 'package:intl/intl.dart';
import 'package:demo_app/globals.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class SkillDetail extends StatefulWidget {
  const SkillDetail({super.key});

  @override
  State<SkillDetail> createState() => _SkillDetailState();
}

class _SkillDetailState extends State<SkillDetail> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: const bottomNavigation(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboard()),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.chevron_left_outlined,
                            color: AppColors.primaryColor, size: 25),
                        Text(
                          'Back',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                    child: Center(
                        child: Text(
                  'Details',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ))),
                const Expanded(child: Text(''))
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                  'Lorem ipsum dolor sit amet and some other very very boring text that no one understands.'),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text('Role'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      'Assistant M3',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text('Date of Assessing'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 5,
                      child: Dropdown(
                        dropdownItems: [],
                        callback: (selectedValue) => {},
                        selectedValue: 1,
                        valueName: 'moduleVersionId',
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text('Supervisor*'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 5,
                      child: Center(
                          child: TextField(
                        controller: dateInput,
                        //editing controller of this TextField
                        decoration: const InputDecoration(
                            icon:
                                Icon(Icons.calendar_today), //icon of text field
                            labelText: "Enter Date" //label text of field
                            ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              dateInput.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      )))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
