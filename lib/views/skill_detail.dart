import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:demo_app/components/button.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

import '../api/api_service.dart';
import '../api/model/instructors.dart';
import '../components/dropdown.dart';
import '../globals.dart';

class SkillDetail extends StatefulWidget {
  final int moduleVersionId;
  final int skillId;
  final String? level;
  final int? instructorId;
  final String? name;

  const SkillDetail({
    Key? key,
    required this.moduleVersionId,
    required this.skillId,
    required this.level,
    this.instructorId,
    this.name,
  }) : super(key: key);

  @override
  State<SkillDetail> createState() => _SkillDetailState();
}

class _SkillDetailState extends State<SkillDetail> {
  TextEditingController dateInput = TextEditingController();
  final SignatureController _controller = SignatureController(
      penStrokeWidth: 1,
      penColor: AppColors.darkGrayColor,
      exportBackgroundColor: Colors.transparent,
      exportPenColor: Colors.black);
  late Future<dynamic> _instructorsFuture;
  int? selectedInstructorId;
  String? selectedLevel;
  String errorMessage = '';

  List<Map<String, String>> levels = [
    {'name': 'Observer', 'level': 'observer'},
    {'name': 'Transition to Assistant', 'level': 'assistant'},
    {'name': 'Transition to Performer', 'level': 'performer'}
  ];

  @override
  void initState() {
    super.initState();
    _instructorsFuture = _getInstructors();
    _instructorsFuture.then((value) async {
      await getDefaultDropdownValueId(value);
    });

    _controller.addListener(() => log('Value changed'));
    dateInput.text = DateFormat('yyyy-MM-dd')
        .format(DateTime.now())
        .toString()
        .split(' ')[0];

    selectedLevel = widget.level;
  }

  String getCurrentUserLevel() {
    if (widget.level != null) {
      for (var levelData in levels) {
        if (levelData['level'] == widget.level) {
          return levelData['level']!;
        }
      }
    }
    return levels[0]['level']!; // Use the first level as a default value
  }

  Future<List<Instructors>> _getInstructors() async {
    final box = Hive.box<Instructors>('instructorsBox');

    // Check if the user is online
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // User is offline, fetch data from Hive
      return box.values.toList();
    }

    // User is online, fetch data from the API
    final fetchedInstructors = await ApiService().getInstructors();

    // Save the data to Hive
    await box.clear(); // Clear the existing data
    await box.addAll([...fetchedInstructors]);

    return fetchedInstructors;
  }

  getDefaultDropdownValueId(value) {
    setState(() {
      selectedInstructorId = widget.instructorId;
    });
  }

  newSupervisorId(value) {
    setState(() {
      _instructorsFuture = _getInstructors();
    });

    _instructorsFuture.then(
      (i) => {
        setState(() {
          selectedInstructorId = value;
        })
      },
    );
  }

  Future _saveSkill() async {
    final Uint8List? signatureData = await _controller.toPngBytes(
      height: 1000,
      width: 1000,
    );

    if (signatureData != null &&
        selectedLevel != null &&
        selectedInstructorId != null) {
      final String signatureBase64 = base64Encode(signatureData);

      var body = jsonEncode({
        "instructor_id": selectedInstructorId,
        "level": selectedLevel,
        "date": dateInput.text,
        "signature": signatureBase64,
      });

      ApiService()
          .saveClinicalSkill(widget.moduleVersionId, widget.skillId, body)
          .then((value) => context.pop())
          .catchError((onError) => {
                setState(() {
                  errorMessage = '${onError.toString()}';
                })
              });
    } else {
      if (selectedInstructorId == null) {
        setState(() {
          errorMessage = 'Please provide an instructor.';
        });
      } else if (signatureData == null) {
        setState(() {
          errorMessage = 'Please provide a signature.';
        });
      }
    }
  }

  @override
  void dispose() {
    // IMPORTANT to dispose of the controller
    _controller.dispose();
    super.dispose();
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

    //final SvgPicture data = _controller.toSVG()!;

    if (!mounted) return;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => context.pop(),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ))),
                    const Expanded(child: Text(''))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Text(widget.name!)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    const Expanded(
                      flex: 2,
                      child: Text('Role'),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 5,
                      child: Dropdown(
                          callback: (selectedItem) {
                            setState(() {
                              selectedLevel = selectedItem;
                            });
                          },
                          dropdownItems: levels,
                          selectedItem: selectedLevel,
                          valueName: 'level',
                          theme: 'dark'),
                    ),
                  ]),
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
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 15),
                              isCollapsed: true,
                              isDense: true,
                              suffixIcon: Icon(
                                Icons.edit_calendar,
                                size: 18,
                                color: AppColors.primaryColor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.placeholderColor,
                                ),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    color: AppColors.primaryLightColor),
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
                                String newDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                String date = newDate.toString().split(' ')[0];
                                setState(() {
                                  dateInput.text = date;
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
                                  final dropdownItems = snapshot.data ?? [];
                                  return Dropdown(
                                      dropdownItems: dropdownItems,
                                      selectedItem: selectedInstructorId,
                                      callback: (value) {
                                        setState(() {
                                          selectedInstructorId = value;
                                        });
                                      },
                                      valueName: 'instructorId',
                                      theme: 'dark');
                                }
                              },
                            ),
                          ))
                    ],
                  ),
                ),
                Button(
                  onClick: () => GoRouter.of(context)
                      .pushNamed('NewSupervisor')
                      .then((value) {
                    if (value != null) {
                      newSupervisorId(value);
                    }
                  }),
                  radius: 8,
                  text: 'Add New Supervisor',
                  theme: 'transparent-dark',
                  buttonHeight: 30,
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
                                fontWeight: FontWeight.normal)),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  child: Signature(
                    key: const Key('signature'),
                    controller: _controller,
                    height: 110,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                errorMessage != ''
                    ? Text(
                        errorMessage,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 213, 93, 91),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                      width: 150,
                      height: 45,
                      child: Button(
                        text: 'Save',
                        onClick: () => _saveSkill(),
                        theme: 'dark',
                        radius: 9,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
