import 'package:demo_app/components/dropdown.dart';
import 'package:demo_app/components/skill_card.dart';
import 'package:flutter/material.dart';

import '../api/api_service.dart';

class SkillCardList extends StatefulWidget {
  const SkillCardList({Key? key}) : super(key: key);

  @override
  State<SkillCardList> createState() => _SkillCardListState();
}

class _SkillCardListState extends State<SkillCardList> {
  late Future<dynamic> _clinicalSkillsFuture;
  late Future<dynamic> _modulesFuture;
  int selectedValue = 0; // Initialize with a default value

  @override
  void initState() {
    super.initState();
    _modulesFuture = _getModules();
    _modulesFuture.then((value) async {
      await getselectedValueId(value);
      _clinicalSkillsFuture = _getClinicalSkills(selectedValue);
      setState(() {});
    });
  }

  Future<void> getselectedValueId(module) async {
    if (selectedValue != 0) {
      setState(() {
        selectedValue = module;
      });
    } else {
      setState(() {
        selectedValue = module[0].moduleVersionId;
      });
    }
  }

  Future<dynamic> _getClinicalSkills(value) {
    return ApiService().getClinicalSkills(value);
  }

  Future<dynamic> _getModules() async {
    return ApiService().getModules();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            'Skills Catalogue',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        FutureBuilder<dynamic>(
          future: _modulesFuture,
          builder: (context, snapshot) {
            final dropdownItems = snapshot.data;
            return dropdown(
              dropdownItems: dropdownItems,
              selectValue: selectedValue, // Set the default selected value
              callback: (value) {
                setState(() {
                  selectedValue =
                      value; // Update selectedValue with the selected value
                  _clinicalSkillsFuture =
                      _getClinicalSkills(value); // Update the Future
                });
              },
            );
          },
        ),
        FutureBuilder<dynamic>(
          future: _clinicalSkillsFuture,
          builder: (context, snapshot) {
            final clinicalSkills = snapshot.data;
            return Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: clinicalSkills?.length ?? 0,
                itemBuilder: (context, index) {
                  return SkillCard(title: clinicalSkills![index].name);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
