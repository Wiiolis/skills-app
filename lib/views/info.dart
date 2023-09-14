import 'package:demo_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Info extends StatefulWidget {
  var user;

  Info({super.key, required this.user});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  late bool hospitalAssigned = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                      Icons.account_circle,
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
                    Text('0151 53157235',
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
              child: widget.user.clinicalRotation.hospitalName != null
                  ? Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                                'assets/images/Clinical_Rotation.svg',
                                color: AppColors.primaryColor,
                                height: 15),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.user.clinicalRotation?.hospitalName,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.account_circle,
                              size: 18,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget
                                    .user.clinicalRotation?.hospitalContact),
                                const Text(
                                  'Teaching hospital manager',
                                  style: TextStyle(
                                      color: AppColors.lightGrayColor),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.email_outlined,
                              size: 18,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(widget.user.clinicalRotation?.hospitalEmail,
                                style: const TextStyle(
                                    decoration: TextDecoration.underline)),
                          ],
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        SvgPicture.asset('assets/images/Clinical_Rotation.svg',
                            color: AppColors.primaryColor, height: 15),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('No Hospital Info')
                      ],
                    ))
        ],
      ),
    );
  }
}
