import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../globals.dart';

class SkillCard extends StatelessWidget {
  final data; // Declare the title variable here.

  const SkillCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      elevation: 3,
      shadowColor: const Color.fromARGB(208, 0, 0, 0),
      color: Colors.white,
      child: FractionallySizedBox(
          widthFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 80),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(data.name)), // Use the title prop here.
                      const SizedBox(
                        width: 10,
                      ),
                      const SizedBox(
                        width: 25,
                        child: Icon(
                          Icons.star_border_rounded,
                          color: AppColors.goldColor,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Assistant M3',
                        style: TextStyle(
                            color: AppColors.greenColor,
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
                            : 'date unavailable',
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
                                : 'No instructor',
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
          )),
    );
  }
}
