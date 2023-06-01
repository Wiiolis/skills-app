import 'package:flutter/material.dart';
import 'login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final apiBaseUrl = const String.fromEnvironment('API_BASE_URL', defaultValue: 'https://gamma.staging.candena.de');
  runApp(MyApp(apiBaseUrl: apiBaseUrl));
}

class MyApp extends StatelessWidget {
  final String apiBaseUrl;

  MyApp({Key? key, required this.apiBaseUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(apiBaseUrl: apiBaseUrl),
    );
  }
}

