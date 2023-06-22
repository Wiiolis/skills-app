import 'package:demo_app/globals.dart';
import 'package:flutter/material.dart';

class DocumentBox extends StatelessWidget {
  const DocumentBox({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: SizedBox(
        width: 150,
        height: 190,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.file_copy_outlined,
                      color: AppColors.primaryColor, size: 40),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Absence Form',
                  ),
                ],
              ),
              TextButton(
                style: ButtonStyle(),
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Open',
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                    Icon(
                      Icons.arrow_outward_rounded,
                      color: AppColors.primaryColor,
                      size: 15,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
