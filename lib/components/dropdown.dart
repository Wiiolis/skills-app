import 'package:demo_app/globals.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class dropdown extends StatelessWidget {
  final List<dynamic> dropdownItems;

  const dropdown({Key? key, required this.dropdownItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 35,
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 0, 8, 0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: DropdownButton<dynamic>(
          iconEnabledColor: AppColors.primaryColor,
          isExpanded: true,
          hint: const Text(
            'Module 1 (Current Module)',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: AppColors.primaryColor, fontWeight: FontWeight.w600),
          ),
          style: const TextStyle(fontSize: 14, color: AppColors.darkGrayColor),
          underline: const SizedBox(),
          items: dropdownItems.map((dynamic value) {
            return DropdownMenuItem<dynamic>(
              value: value.name,
              child: Text(value.name),
            );
          }).toList(),
          onChanged: (_) {},
        ),
      ),
    );
  }
}
