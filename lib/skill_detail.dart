import 'dart:developer';
import 'dart:typed_data';

import 'package:demo_app/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

import 'api/api_service.dart';
import 'components/dropdown.dart';
import 'globals.dart';

class SkillDetail extends StatefulWidget {
  const SkillDetail({super.key});

  @override
  State<SkillDetail> createState() => _SkillDetailState();
}

class _SkillDetailState extends State<SkillDetail> {
  // initialize the signature controller
  TextEditingController dateInput = TextEditingController();
  final SignatureController _controller = SignatureController(
      penStrokeWidth: 1,
      penColor: AppColors.darkGrayColor,
      exportBackgroundColor: Colors.transparent,
      exportPenColor: Colors.black);
  late Future<dynamic> _instructorsFuture;
  int selectedValue = 0; // Initialize with a default value

  @override
  void initState() {
    super.initState();
    _instructorsFuture = _getInstructors();
    _instructorsFuture.then((value) async {
      await getselectedValueId(value);
    });

    _controller.addListener(() => log('Value changed'));
    dateInput.text = DateFormat('dd.MM.yyyy')
        .format(DateTime.now())
        .toString()
        .split(' ')[0];
  }

  Future<void> getselectedValueId(instructor) async {
    if (selectedValue != 0) {
      setState(() {
        selectedValue = instructor;
      });
    } else {
      setState(() {
        selectedValue = instructor[0].instructorId;
      });
    }
  }

  @override
  void dispose() {
    // IMPORTANT to dispose of the controller
    _controller.dispose();
    super.dispose();
  }

  Future<dynamic> _getInstructors() async {
    return ApiService().getInstructors();
  }

  Future<void> exportImage(BuildContext context) async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          key: Key('snackbarPNG'),
          content: Text('No content'),
        ),
      );
      return;
    }

    final Uint8List? data =
        await _controller.toPngBytes(height: 1000, width: 1000);
    if (data == null) {
      return;
    }

    if (!mounted) return;
  }

  Future<void> exportSVG(BuildContext context) async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          key: Key('snackbarSVG'),
          content: Text('No content'),
        ),
      );
      return;
    }

    final SvgPicture data = _controller.toSVG()!;

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.go("/"),
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
                        child: FutureBuilder<dynamic>(
                          future: _instructorsFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final dropdownItems =
                                  snapshot.data ?? []; // Handle null data
                              return Dropdown(
                                dropdownItems: dropdownItems,
                                selectedValue:
                                    selectedValue, // Set the default selected value
                                callback: (value) {
                                  setState(() {
                                    selectedValue = value; // Update the Future
                                  });
                                },
                                valueName: 'instructorId',
                              );
                            }
                          },
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
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Supervisor signature',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _controller.clear(),
                    child: const Text('Clear',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            Signature(
              key: const Key('signature'),
              controller: _controller,
              height: 150,
              backgroundColor: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                    width: 150,
                    child: Expanded(
                        child: Button(
                            text: 'Save', onClick: () {}, theme: 'dark'))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
