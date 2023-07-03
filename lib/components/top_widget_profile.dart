import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_service.dart';
import '../login.dart';

class TopWidgetProfile extends StatefulWidget {
  const TopWidgetProfile({Key? key}) : super(key: key);

  @override
  _TopWidgetProfileState createState() => _TopWidgetProfileState();
}

class _TopWidgetProfileState extends State<TopWidgetProfile> {
  @override
  void initState() {
    super.initState();
    _getToken();
  }

  dynamic apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://gamma.staging.candena.de',
  );

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login(apiBaseUrl: apiBaseUrl),
      ),
    );
  }

  Future<dynamic> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    if (token != null) {
      var currentUser = await ApiService().getCurrentUser();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(apiBaseUrl: apiBaseUrl),
        ),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () => _logout(context),
      ),
    );
  }
}
