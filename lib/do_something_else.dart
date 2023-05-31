import 'package:flutter/material.dart';

class DoSomethingElseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Do Something Else"),
      ),
      body: Center(child: Text("Welcome to the Do Something Else screen!")),
    );
  }
}
