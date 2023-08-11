import 'package:demo_app/globals.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            'EDU Contact Person',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.verified_user_sharp,
                    size: 18,
                    color: AppColors.goldColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Judih Schimann'),
                      Text(
                        'Teaching hospital manager',
                        style: TextStyle(color: AppColors.lightGrayColor),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(
                    Icons.email_outlined,
                    color: AppColors.goldColor,
                    size: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'clinical.rotation@edu.edu.mt',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(
                    Icons.phone_outlined,
                    size: 18,
                    color: AppColors.goldColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('0123 456 789',
                      style: TextStyle(decoration: TextDecoration.underline)),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                color: AppColors.goldColor,
                thickness: 1,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            'Hospital info',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: AppColors.primaryColor,
                      size: 18,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'clinical.rotation@edu.edu.mt',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.verified_user_sharp,
                      size: 18,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Judih Schimann'),
                        Text(
                          'Teaching hospital manager',
                          style: TextStyle(color: AppColors.lightGrayColor),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: 18,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('0123 456 789',
                        style: TextStyle(decoration: TextDecoration.underline)),
                  ],
                ),
              ],
            ))
      ],
    );
  }
}
