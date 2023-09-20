import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hive_adapters.dart';
import 'router.dart';

import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(document.path);

  await registerHiveAdapters();
  print('mainn');

  const apiBaseUrl = String.fromEnvironment('API_BASE_URL',
      defaultValue: 'https://gamma.staging.candena.de');

  final userData = await _getUserData();

  runApp(MyApp(apiBaseUrl: apiBaseUrl, userData: userData));
}

Future<Map<String, dynamic>?> _getUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final userDataJson = prefs.getString('userData');
  if (userDataJson != null) {
    return jsonDecode(userDataJson) as Map<String, dynamic>;
  }
  return null;
}

class MyApp extends StatelessWidget {
  final String apiBaseUrl;
  final Map<String, dynamic>? userData; // Modify the userData parameter

  MyApp({Key? key, required this.apiBaseUrl, this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp.router(
          theme: ThemeData(fontFamily: 'OpenSans'),
          routerConfig: router,
          debugShowCheckedModeBanner: false),
    );
  }
}
