import 'package:demo_app/components/skill_card.dart';
import 'package:flutter/material.dart';

class SkillCardList extends StatefulWidget {
  const SkillCardList({super.key});

  @override
  State<SkillCardList> createState() => _SkillCardListState();
}

class _SkillCardListState extends State<SkillCardList> {
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
        SingleChildScrollView(
          child: Expanded(
            child: SizedBox(
              height: 300,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const SkillCard();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
