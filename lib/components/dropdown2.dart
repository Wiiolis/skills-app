import 'dart:convert';

import 'package:flutter/material.dart';

import '../globals.dart';

typedef DropdownCallback = void Function(dynamic selectedItem);

class Dropdown2 extends StatefulWidget {
  final List<dynamic> dropdownItems;
  var selectedItem;
  final DropdownCallback callback;
  final String valueName;

  Dropdown2({
    Key? key,
    required this.dropdownItems,
    required this.selectedItem,
    required this.valueName,
    required this.callback,
  }) : super(key: key);

  @override
  State<Dropdown2> createState() => _Dropdown2State();
}

class _Dropdown2State extends State<Dropdown2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 150,
        height: 40,
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 0, 8, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.placeholderColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: DropdownButton(
            focusColor: Colors.transparent,
            iconEnabledColor: AppColors.primaryColor,
            isExpanded: true,
            hint: const Text(
              'Role',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.darkGrayColor,
              ),
            ),
            style:
                const TextStyle(fontSize: 14, color: AppColors.darkGrayColor),
            underline: const SizedBox(),
            value: widget.selectedItem,
            items: widget.dropdownItems.map((dynamic value) {
              return DropdownMenuItem<dynamic>(
                value: widget.valueName == 'instructorId'
                    ? value.instructorId
                    : value,
                child: Text(valueName(value)), // Use a function to extract name
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                widget.selectedItem = newValue!;
              });
              widget.callback(newValue!);
            },
          ),
        ));
  }

  String valueName(dynamic value) {
    if (value is String) {
      return value;
    } else if (value is Map<String, dynamic>) {
      return value['name'];
    } else {
      return value.name.toString();
    }
  }
}
