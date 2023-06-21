import 'package:flutter/material.dart';

class TopWidgetProfile extends StatelessWidget {
  const TopWidgetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Icon(Icons.person_outlined),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Kristina Maximova',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Module 2',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ],
              ),
              Text(
                'Some Cool Hospital Name',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ],
          )
        ],
      ),
    );
  }
}
