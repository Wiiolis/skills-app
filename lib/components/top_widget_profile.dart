import 'package:flutter/material.dart';

class TopWidgetProfile extends StatelessWidget {
  const TopWidgetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                Icons.person_outlined,
                size: 38,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Kristina Maximova',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, height: 1.50),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Module 2',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(height: 1.50)),
                    ],
                  ),
                  Text('Some Cool Hospital Name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(height: 1.50)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
