import 'dart:convert';

import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const apiBaseUrl = String.fromEnvironment('API_BASE_URL',
      defaultValue: 'https://gamma.staging.candena.de');

  // Get the user data from persistent storage
  final userData = await _getUserData();

  // Check if user data exists
  if (userData != null) {
    runApp(MyApp(
      apiBaseUrl: apiBaseUrl,
      userData: userData,
    ));
  } else {
    runApp(MyApp(
      apiBaseUrl: apiBaseUrl,
      userData: {},
    ));
  }
}

Future<Map<String, dynamic>?> _getUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final userData = prefs.getString('userData');
  if (userData != null) {
    return jsonDecode(userData) as Map<String, dynamic>;
  }
  return null;
}

class MyApp extends StatelessWidget {
  final String apiBaseUrl;
  final userData;

  const MyApp({Key? key, required this.apiBaseUrl, required this.userData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var x = userData;
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: x == null ? Login(apiBaseUrl: apiBaseUrl) : Dashboard(),
      ),
    );
  }
}
