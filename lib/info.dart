import 'package:demo_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

checkHospital() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('hospitalAssigned');
}

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            'EDU Contact Person',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
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
        const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            'Hospital info',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
            padding: const EdgeInsets.all(15),
            child: checkHospital() == true
                ? const Column(
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
                            style:
                                TextStyle(decoration: TextDecoration.underline),
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
                                style:
                                    TextStyle(color: AppColors.lightGrayColor),
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
                              style: TextStyle(
                                  decoration: TextDecoration.underline)),
                        ],
                      ),
                    ],
                  )
                : const Row(
                    children: [
                      Icon(
                        Icons.house_outlined,
                        color: AppColors.primaryColor,
                      ),
                      Text('No Hospital Info')
                    ],
                  ))
      ],
    );
  }
}
