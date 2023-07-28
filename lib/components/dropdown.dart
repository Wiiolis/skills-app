import 'package:demo_app/globals.dart';
import 'package:flutter/material.dart';

class dropdown extends StatelessWidget {
  const dropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 35,
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 8, 0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: DropdownButton<String>(
          iconEnabledColor: AppColors.primaryColor,
          isExpanded: true,
          hint: const Text(
            'Module 1 (Current Module)',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: AppColors.primaryColor, fontWeight: FontWeight.w600),
          ),
          style: TextStyle(fontSize: 14, color: AppColors.darkGrayColor),
          underline: SizedBox(),
          items: <String>['A', 'B', 'C', 'D'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        ),
      ),
    );
  }
}
