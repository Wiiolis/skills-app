import 'package:flutter/material.dart';

import '../globals.dart';

class SkillCard extends StatelessWidget {
  const SkillCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      elevation: 4,
      shadowColor: Colors.black,
      color: Colors.white,
      child: FractionallySizedBox(
          widthFactor: 1,
          child: SizedBox(
            height: 90,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Skill 21'),
                      Icon(Icons.star_border_rounded,
                          color: AppColors.goldColor),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
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
                      Icon(Icons.chevron_right, color: AppColors.primaryColor),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
