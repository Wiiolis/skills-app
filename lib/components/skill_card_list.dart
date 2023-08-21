import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../api/api_service.dart';
import '../globals.dart';
import '../components/dropdown.dart';
import '../components/skill_card.dart';

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

  TextEditingController _searchController = TextEditingController();
  List<dynamic> clinicalSkills = [];
  List<dynamic> filteredSkills = [];

  @override
  void initState() {
    super.initState();
    _modulesFuture = _getModules();
    _modulesFuture.then((value) async {
      await getselectedValueId(value);
      setState(() {
        _clinicalSkillsFuture = _getClinicalSkills(selectedModuleVersionId);
      });

      getFilteredSkills();
    });

    filterSkills(null);
  }

  getFilteredSkills() {
    return _clinicalSkillsFuture.then((value) => {
          setState(() {
            clinicalSkills = value;
            filteredSkills = List.from(clinicalSkills);
          })
        });
  }

  Future<void> getselectedValueId(module) async {
    setState(() {
      selectedModuleVersionId = module[0].moduleVersionId;
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
    if (widget.user.clinicalRotation.hospitalName != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          SizedBox(
            height: 35,
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              controller: _searchController,
              onChanged: (value) {
                filterSkills(value);
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.primaryColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  borderSide: BorderSide(color: AppColors.primaryLightColor),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Search skill by name',
                hintStyle: TextStyle(
                  color: AppColors.placeholderColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
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
                  selectedValue: selectedModuleVersionId,
                  callback: (value) {
                    setState(() {
                      selectedModuleVersionId = value;
                      _clinicalSkillsFuture = _getClinicalSkills(value);
                      getFilteredSkills();
                      _searchController.clear();
                    });
                  },
                  valueName: 'moduleVersionId',
                );
              }
            },
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
                          context.goNamed("skillDetail", pathParameters: {
                            "moduleVersionId":
                                selectedModuleVersionId.toString(),
                            "skillId":
                                clinicalSkills[index].clinicalSkillId.toString()
                          }, queryParameters: {
                            "level": clinicalSkills[index].level
                          });
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
        child: Expanded(
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
      );
    }
  }

  void filterSkills(String? query) {
    if (query == null || query.isEmpty) {
      setState(() {
        filteredSkills =
            List.from(clinicalSkills); // Reset filteredSkills to all skills
      });
    } else {
      setState(() {
        filteredSkills = clinicalSkills.where((skill) {
          return skill.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }
}
