import 'package:demo_app/components/dropdown.dart';
import 'package:demo_app/components/skill_card.dart';
import 'package:flutter/material.dart';

import '../api/api_service.dart';

class SkillCardList extends StatefulWidget {
  const SkillCardList({super.key});

  @override
  State<SkillCardList> createState() => _SkillCardListState();
}

class _SkillCardListState extends State<SkillCardList> {
  late Future<dynamic> _clinicalSkillsFuture;
  late Future<dynamic> _modulesFuture;

  @override
  void initState() {
    super.initState();
    _clinicalSkillsFuture = _getClinicalSkills();
    _modulesFuture = _getModules();
  }

  Future<dynamic> _getClinicalSkills() {
    return ApiService().getClinicalSkills(109);
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
        dropdown(),
        FutureBuilder<dynamic>(
            future: _clinicalSkillsFuture,
            builder: (context, snapshot) {
              final clinicalSkills = snapshot.data;
              return Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: clinicalSkills.length,
                  itemBuilder: (context, index) {
                    return SkillCard(title: clinicalSkills[index].name);
                  },
                ),
              );
            }),
      ],
    );
  }
}
