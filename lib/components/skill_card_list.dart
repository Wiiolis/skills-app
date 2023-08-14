import 'package:demo_app/components/dropdown.dart';
import 'package:demo_app/components/skill_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/api_service.dart';
import '../globals.dart';

class SkillCardList extends StatefulWidget {
  const SkillCardList({Key? key}) : super(key: key);

  @override
  State<SkillCardList> createState() => _SkillCardListState();
}

class _SkillCardListState extends State<SkillCardList> {
  late Future<dynamic> _clinicalSkillsFuture = Future<dynamic>.value([]);
  late Future<dynamic> _modulesFuture;
  int selectedValue = 0; // Initialize with a default value

  @override
  void initState() {
    super.initState();
    _modulesFuture = _getModules();
    _modulesFuture.then((value) async {
      await getselectedValueId(value);
      setState(() {
        _clinicalSkillsFuture = _getClinicalSkills(selectedValue);
      });
    });
  }

  checkHospital() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hospitalAssigned');
  }

  Future<void> getselectedValueId(module) async {
    setState(() {
      selectedValue = module[0].moduleVersionId;
    });
  }

  Future<dynamic> _getClinicalSkills(value) {
    return ApiService().getClinicalSkills(value);
  }

  Future<dynamic> _getModules() async {
    return ApiService().getModules();
  }

  @override
  Widget build(BuildContext context) {
    if (checkHospital() == true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              'Skills Catalogue',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          FutureBuilder<dynamic>(
            future: _modulesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final dropdownItems = snapshot.data ?? []; // Handle null data
                return Dropdown(
                  dropdownItems: dropdownItems,
                  selectedValue:
                      selectedValue, // Set the default selected value
                  callback: (value) {
                    setState(() {
                      selectedValue =
                          value; // Update selectedValue with the selected value
                      _clinicalSkillsFuture =
                          _getClinicalSkills(value); // Update the Future
                    });
                  },
                  valueName: 'moduleVersionId',
                );
              }
            },
          ),
          const SizedBox(
            height: 5,
          ),
          FutureBuilder<dynamic>(
            future: _clinicalSkillsFuture,
            builder: (context, snapshot) {
              final clinicalSkills = snapshot.data;
              if (clinicalSkills == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: clinicalSkills?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            context.go("/skill-detail");
                          },
                          child: SkillCard(data: clinicalSkills![index]));
                    },
                  ),
                );
              }
            },
          ),
        ],
      );
    } else {
      return SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/placeholder.svg',
              ),
              const Text(
                'Hello, Jane!',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              const Text('You’re not in Clinical Rotation currently.',
                  style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'You can stay and explore the app or ',
                      style: const TextStyle(
                          fontSize: 16, color: AppColors.darkGrayColor),
                    ),
                    TextSpan(
                      text: 'Go to the Platform',
                      style: const TextStyle(
                          fontSize: 16, color: AppColors.goldColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(
                              'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'
                                  as Uri);
                        },
                    ),
                    new TextSpan(
                      text:
                          ' and come back when your Clinical Rotation starts!',
                      style: const TextStyle(
                          fontSize: 16, color: AppColors.darkGrayColor),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
