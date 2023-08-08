import 'package:flutter/material.dart';

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
                      const Text(
                        '06.02.2023',
                        style: TextStyle(
                            color: AppColors.lightGrayColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: data.assessment != null
                            ? Text(data.assessment.instructor.fullName,
                                style: const TextStyle(
                                    color: AppColors.lightGrayColor,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12))
                            : const Text(''),
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
