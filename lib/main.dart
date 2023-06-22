import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final apiBaseUrl = const String.fromEnvironment('API_BASE_URL',
      defaultValue: 'https://gamma.staging.candena.de');
  runApp(MyApp(apiBaseUrl: apiBaseUrl));
}

class MyApp extends StatelessWidget {
  final String apiBaseUrl;

  MyApp({Key? key, required this.apiBaseUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'OpenSans'),
      home: const RootPage(), //Scaffold
    ); // MaterialApp
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: false
          ? Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_outlined),
                    label: 'Skills',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.file_copy_outlined),
                    label: 'Documents',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.info),
                    label: 'Info',
                  ),
                ],
              ),
              body: const Dashboard())
          : Scaffold(body: Login()),
    );
  }
}
