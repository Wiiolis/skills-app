import 'package:demo_app/components/document_box.dart';
import 'package:flutter/material.dart';

class Documents extends StatefulWidget {
  const Documents({super.key});

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            'Documents',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(children: [DocumentBox(), DocumentBox()])
      ],
    );
  }
}