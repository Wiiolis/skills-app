import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_app/components/my_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';
import '../api/api_service.dart';
import '../api/model/clinical_skills.dart';
import '../api/model/modules.dart';
import '../globals.dart';
import '../components/dropdown.dart';
import '../components/skill_card.dart';
import 'button.dart';

class SkillCardList extends StatefulWidget {
  final user;

  const SkillCardList({Key? key, required this.user}) : super(key: key);

  @override
  State<SkillCardList> createState() => _SkillCardListState();
}

class _SkillCardListState extends State<SkillCardList> {
  late Future<dynamic> _clinicalSkillsFuture = Future<dynamic>.value([]);
  late Future<dynamic> _modulesFuture;
  int selectedModuleVersionId = 0;
  late bool hospitalAssigned = false;
  bool filterCompletedSkills = false;

  TextEditingController _searchController = TextEditingController();
  List<dynamic> clinicalSkills = [];
  List<dynamic> filteredSkills = [];
  List<dynamic> copyClinicalSkills = [];

  @override
  void initState() {
    super.initState();
    _modulesFuture = _getModules();
    _modulesFuture.then((value) async {
      if (mounted) {
        await getSelectedValueId(value);
        setState(() {
          _clinicalSkillsFuture = _getClinicalSkills(selectedModuleVersionId);
        });

        getFilteredSkills();
      }
    });
  }

  getFilteredSkills() {
    return _clinicalSkillsFuture.then((value) {
      if (mounted) {
        setState(() {
          clinicalSkills = value;
          filteredSkills = List.from(clinicalSkills);
          copyClinicalSkills = List.from(clinicalSkills);
        });
      }
    });
  }

  void switchCompletedFilter() {
    if (!filterCompletedSkills) {
      var completedSkills =
          clinicalSkills.where((skill) => skill.assessment != null).toList();
      filterSkills(_searchController.text, completedSkills);
      filterCompletedSkills = true;
    } else {
      filterSkills(_searchController.text, copyClinicalSkills);
      filterCompletedSkills = false;
    }
  }

  void filterSkills(String query, List<dynamic> skillsList) {
    if (query.isEmpty) {
      setState(() {
        filteredSkills = List.from(skillsList);
      });
    } else {
      setState(() {
        filteredSkills = skillsList.where((skill) {
          return skill.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  Future<void> getSelectedValueId(module) async {
    if (module != null) {
      setState(() {
        selectedModuleVersionId = module[0].moduleVersionId;
      });
    }
  }

  Future<List<ClinicalSkills>> _getClinicalSkills(value) async {
    final box = Hive.box<ClinicalSkills>('clinicalSkillsBox');

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return box.values.toList();
    }

    final fetchedClinicalSkills = await ApiService().getClinicalSkills(value);

    await box.clear();
    await box.addAll(fetchedClinicalSkills);

    return fetchedClinicalSkills;
  }

  Future<List<Modules>> _getModules() async {
    final box = Hive.box<Modules>('modulesBox');

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return box.values.toList();
    }

    final fetchedModules = await ApiService().getModules();

    await box.clear();
    await box.addAll(fetchedModules);

    return fetchedModules;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user.clinicalRotation.hospitalName != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          SizedBox(
              height: 55,
              child: MyTextField(
                onChanged: (value) {
                  if (filterCompletedSkills) {
                    filterSkills(
                        value,
                        clinicalSkills
                            .where((skill) => skill.assessment != null)
                            .toList());
                  } else {
                    filterSkills(value, copyClinicalSkills);
                  }
                },
                controller: _searchController,
                required: false,
                hintText: 'Search skills by name',
                obscureText: false,
                displayBorder: false,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primaryColor,
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              FutureBuilder<dynamic>(
                future: _modulesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final dropdownItems = snapshot.data ?? [];
                    return Dropdown(
                        dropdownItems: dropdownItems,
                        selectedItem: selectedModuleVersionId,
                        dropdownWidth: 150,
                        callback: (value) {
                          setState(() {
                            selectedModuleVersionId = value;
                            _clinicalSkillsFuture = _getClinicalSkills(value);
                            getFilteredSkills();
                            filterCompletedSkills = false;
                            _searchController.clear();
                          });
                        },
                        valueName: 'moduleVersionId',
                        theme: 'light');
                  }
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Button(
                  icon: filterCompletedSkills == true ? 'check' : null,
                  text: 'Completed',
                  onClick: () => switchCompletedFilter(),
                  theme: filterCompletedSkills == true
                      ? 'dark'
                      : 'transparent-dark',
                  radius: 20,
                  buttonWidth: 110,
                  buttonHeight: 35),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
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
            future: _clinicalSkillsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Flexible(
                  child: ListView.builder(
                    itemCount: filteredSkills.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            "skillDetail",
                            pathParameters: {
                              "moduleVersionId":
                                  selectedModuleVersionId.toString(),
                              "skillId": filteredSkills[index]
                                  .clinicalSkillId
                                  .toString(),
                            },
                            queryParameters: {
                              "name": filteredSkills[index].name,
                              "level":
                                  filteredSkills[index].assessment?.level ??
                                      'observer',
                              "instructorId": filteredSkills[index]
                                  .assessment
                                  ?.instructor
                                  .instructorId
                                  .toString()
                            },
                          );
                        },
                        child: SkillCard(data: filteredSkills[index]),
                      );
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
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/placeholder.svg',
                    height: 237,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Hello, Jane!',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('You’re not in Clinical Rotation currently.',
                      style: TextStyle(fontSize: 16)),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: SizedBox(
                      width: 300,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'You can stay and explore the app or ',
                              style: TextStyle(
                                  fontSize: 16, color: AppColors.darkGrayColor),
                            ),
                            TextSpan(
                              text: 'Go to the Platform',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.goldColor,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(
                                      'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'
                                          as Uri);
                                },
                            ),
                            const TextSpan(
                              text:
                                  ' and come back when your Clinical Rotation starts!',
                              style: TextStyle(
                                  fontSize: 16, color: AppColors.darkGrayColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
