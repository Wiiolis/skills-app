import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';

class TopWidgetProfile extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const TopWidgetProfile({Key? key, this.userData}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    // Clear the user data from persistent storage
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');

    const apiBaseUrl = String.fromEnvironment('API_BASE_URL',
        defaultValue: 'https://gamma.staging.candena.de');

    // Navigate back to the login screen or any desired screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login(apiBaseUrl: apiBaseUrl)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Icon(
                Icons.person_outlined,
                size: 38,
              ),
              const SizedBox(width: 15),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Kristina Maximova',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, height: 1.50),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Module 2',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(height: 1.50)),
                    ],
                  ),
                  Text('Some Cool Hospital Name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(height: 1.50)),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () =>
                    _logout(context), // Call the logout method on button press
              )
            ],
          ),
        ],
      ),
    );
  }
}
