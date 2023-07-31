import 'package:flutter/material.dart';

import '../globals.dart';

class dropdown extends StatelessWidget {
  final List<dynamic> dropdownItems;
  final Function(int) callback;

  const dropdown(
      {super.key, required this.dropdownItems, required this.callback});

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
              value: value.moduleVersionId,
              child: Text(value.name),
            );
          }).toList(),
          onChanged: (dynamic newValue) {
            callback(newValue);
          },
        ),
      ),
    );
  }
}
