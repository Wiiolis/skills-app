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
    dateInput.text = DateFormat('dd.MM.yyyy')
        .format(DateTime.now())
        .toString()
        .split(' ')[0];

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
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: dateInput,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                          isCollapsed: true,
                          isDense: true,
                          suffixIcon: Icon(
                            Icons.edit_calendar,
                            size: 18,
                            color: AppColors.primaryColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                              width: 1,
                              color: AppColors.placeholderColor,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                                BorderSide(color: AppColors.primaryLightColor),
                          ),
                        ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              initialDate: DateTime.now(),
                              context: context,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2024));
                          if (pickedDate != null) {
                            //pickedDate output format => 2021-03-10 00:00:00.000
                            String newDate =
                                DateFormat('dd.MM.yyyy').format(pickedDate);
                            String date = newDate.toString().split(' ')[0];

                            //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              dateInput.text = date;
                              //set output date to TextField value.
                            });
                          } else {}
                        },
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
                      child: SizedBox(
                        height: 40,
                        child: Dropdown(
                          dropdownItems: [],
                          callback: (selectedValue) => {},
                          selectedValue: 1,
                          valueName: 'moduleVersionId',
                        ),
                      ))
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(''),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Expanded(
                      flex: 5,
                      child: SizedBox(
                          height: 40,
                          child: Text(
                            '+ Add new Supervisor',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: AppColors.primaryLightColor),
                          )))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
