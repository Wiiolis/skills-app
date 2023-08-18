import 'package:flutter/material.dart';

import '../globals.dart';

typedef DropdownCallback = void Function(int selectedValue);

class Dropdown extends StatefulWidget {
  final List<dynamic> dropdownItems;
  dynamic selectedValue;
  var valueName;
  final DropdownCallback callback; // Add callback property

  Dropdown({
    Key? key,
    required this.dropdownItems,
    required this.selectedValue,
    required this.valueName,
    required this.callback, // Initialize callback in the constructor
  }) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 35,
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 0, 8, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: DropdownButton<int>(
          // Change the DropdownButton type to int
          iconEnabledColor: AppColors.primaryColor,
          isExpanded: true,
          hint: const Text(
            'Module 1 (Current Module)',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.darkGrayColor,
          ),
          underline: const SizedBox(),
          value: widget.selectedValue,
          items: widget.dropdownItems.map((dynamic value) {
            return DropdownMenuItem<int>(
              value: widget.valueName == 'moduleVersionId'
                  ? value.moduleVersionId
                  : value.instructorId,
              child: Text(value.name),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              widget.selectedValue = newValue!; // Update the selected value
            });
            widget.callback(
                newValue!); // Call the callback function with the selected value
          },
        ),
      ),
    );
  }
}
