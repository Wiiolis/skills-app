import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../globals.dart';

// ignore: must_be_immutable
class SkillCard extends StatelessWidget {
  final data;
  bool pendingBackground = false;

  SkillCard({
    Key? key,
    required this.data,
    required this.pendingBackground,
  }) : super(key: key);

  String getLevelName(String level) {
    List levelName = levels.where((o) => o.containsValue(level)).toList();

    return levelName[0]['name'].toString();
  }

  List levels = [
    {'name': 'Observer', 'level': 'observer'},
    {'name': 'Transition to Assistant', 'level': 'assistant'},
    {'name': 'Transition to Performer', 'level': 'performer'}
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      elevation: 3,
      shadowColor: const Color.fromARGB(208, 0, 0, 0),
      color: pendingBackground ? AppColors.placeholderColor : Colors.white,
      child: Stack(children: [
        /*   const Positioned(
          top: 10,
          right: 15,
          child: Icon(
            Icons.star_border_rounded,
            color: AppColors.goldColor,
            size: 26,
          ),
        ), */
        FractionallySizedBox(
          widthFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 80),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          pendingBackground
                              ? const Row(
                                  children: [
                                    Icon(
                                      Icons.wifi_off,
                                      color: AppColors.lightGrayColor,
                                      size: 13,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '(Pending)',
                                      style: TextStyle(
                                          color: AppColors.lightGrayColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 30, 0),
                        child: Text(
                          data.name,
                          style: const TextStyle(
                              color: AppColors.darkGrayColor,
                              fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        data.assessment?.level != null
                            ? getLevelName(data.assessment?.level)
                            : 'No Role',
                        style: TextStyle(
                            color: data.assessment?.level != null
                                ? AppColors.greenColor
                                : AppColors.lightGrayColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        data.assessment != null
                            ? DateFormat('dd.MM.yyyy')
                                .format(data.assessment.assessmentDate)
                                .toString()
                            : '',
                        style: const TextStyle(
                            color: AppColors.lightGrayColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                            data.assessment != null
                                ? data.assessment.instructor.fullName
                                : '',
                            style: const TextStyle(
                                color: AppColors.lightGrayColor,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w300,
                                fontSize: 12)),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: AppColors.primaryColor,
                        size: 26,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
