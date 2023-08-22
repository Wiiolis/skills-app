import 'package:flutter/material.dart';

import '../globals.dart';

typedef DropdownCallback = void Function(int selectedValue);

class Dropdown extends StatefulWidget {
  final List<dynamic> dropdownItems;
  int selectedValue;
  var valueName;
  final DropdownCallback callback;
  String theme = 'light'; //light or dark

  Dropdown({
    Key? key,
    required this.dropdownItems,
    required this.selectedValue,
    required this.valueName,
    required this.callback,
    required this.theme,
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
          border: Border.all(
              color: widget.theme == 'dark'
                  ? AppColors.placeholderColor
                  : Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        child: DropdownButton<int>(
          focusColor: Colors.transparent,
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
          style: TextStyle(
            fontWeight:
                widget.theme == 'dark' ? FontWeight.w400 : FontWeight.w600,
            fontSize: 14,
            color: widget.theme == 'dark'
                ? AppColors.darkGrayColor
                : AppColors.primaryColor,
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
              widget.selectedValue = newValue!;
            });
            widget.callback(newValue!);
          },
        ),
      ),
    );
  }
}
