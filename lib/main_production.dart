import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(IconsOverride(
    child: const MyApp(
      apiBaseUrl:
          String.fromEnvironment('API_BASE_URL', defaultValue: 'https://study.edu.edu.mt'),
    ),
  ));
}

void main() {
  runApp(MyApp(apiBaseUrl: 'https://study.edu.edu.mt'));
}
