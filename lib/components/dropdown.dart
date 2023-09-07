import 'dart:convert';

import 'package:flutter/material.dart';

import '../globals.dart';

typedef DropdownCallback = void Function(dynamic selectedItem);

class Dropdown2 extends StatefulWidget {
  final List<dynamic> dropdownItems;
  var selectedItem;
  final DropdownCallback callback;
  final String valueName;
  double dropdownWidth = double.maxFinite;
  String theme = 'light';

  Dropdown2(
      {Key? key,
      required this.dropdownItems,
      required this.selectedItem,
      required this.valueName,
      required this.callback,
      this.dropdownWidth = double.maxFinite,
      required this.theme})
      : super(key: key);

  @override
  State<Dropdown2> createState() => _Dropdown2State();
}

getValue(dynamic value, String valueName) {
  if (valueName == 'instructorId') {
    return value.instructorId;
  } else if (valueName == 'moduleVersionId') {
    return value.moduleVersionId;
  } else {
    return value['level'];
  }
}

class _Dropdown2State extends State<Dropdown2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.dropdownWidth,
        height: 40,
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
          child: DropdownButton(
            focusColor: Colors.transparent,
            iconEnabledColor: AppColors.primaryColor,
            isExpanded: true,
            hint: const Text(
              'Select',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.darkGrayColor,
              ),
            ),
            style: TextStyle(
              fontSize: 14,
              color: widget.theme == 'dark'
                  ? AppColors.darkGrayColor
                  : AppColors.primaryColor,
              fontWeight:
                  widget.theme == 'dark' ? FontWeight.w400 : FontWeight.w600,
            ),
            underline: const SizedBox(),
            value: widget.selectedItem,
            items: widget.dropdownItems.map((dynamic value) {
              return DropdownMenuItem<dynamic>(
                value: getValue(value, widget.valueName),
                child: Text(getValueText(value)),
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

  dynamic getValueText(dynamic value) {
    if (value is String) {
      return value;
    } else if (value is Map<String, dynamic>) {
      return value['name'];
    } else {
      return value.name.toString();
    }
  }
}
