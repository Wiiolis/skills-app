import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const apiBaseUrl = String.fromEnvironment('API_BASE_URL',
      defaultValue: 'https://gamma.staging.candena.de');
  runApp(const MyApp(apiBaseUrl: apiBaseUrl));
}

class MyApp extends StatelessWidget {
  final String apiBaseUrl;
  const MyApp({Key? key, required this.apiBaseUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(apiBaseUrl: apiBaseUrl),
      ),
    );
  }
}
