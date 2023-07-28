import 'package:flutter/material.dart';

import '../globals.dart';

class SkillCard extends StatelessWidget {
  final String title; // Declare the title variable here.

  const SkillCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      elevation: 3,
      shadowColor: Color.fromARGB(208, 0, 0, 0),
      color: Colors.white,
      child: FractionallySizedBox(
          widthFactor: 1,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 80),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(title)), // Use the title prop here.
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 25,
                        child: const Icon(
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
                  const Row(
                    children: [
                      Text(
                        'Assistant M3',
                        style: TextStyle(
                            color: AppColors.greenColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '06.02.2023',
                        style: TextStyle(
                            color: AppColors.lightGrayColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Kristina Maximova',
                          style: TextStyle(
                              color: AppColors.lightGrayColor,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w300,
                              fontSize: 12),
                        ),
                      ),
                      Icon(
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
