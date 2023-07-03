import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_service.dart';
import '../login.dart';

class TopWidgetProfile extends StatefulWidget {
  const TopWidgetProfile({Key? key}) : super(key: key);

  @override
  _TopWidgetProfileState createState() => _TopWidgetProfileState();
}

Future<void> _logout(BuildContext context) async {
  // Clear the user data from persistent storage
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('userData');

  const apiBaseUrl = String.fromEnvironment('API_BASE_URL',
      defaultValue: 'https://gamma.staging.candena.de');

  // Navigate back to the login screen or any desired screen
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => const Login(apiBaseUrl: apiBaseUrl)),
  );
}

class _TopWidgetProfileState extends State<TopWidgetProfile> {
  late Future<dynamic> _userData;

  @override
  void initState() {
    super.initState();
    _userData = _getUserById();
  }

  Future<dynamic> _getUserById() async {
    var user = await ApiService().getCurrentUser();
    if (user.isNotEmpty) {
      var userById = await ApiService().getUser(user[0].currentUserId);
      return userById[0];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: FutureBuilder(
        future: _userData,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text(
                'Error: ${snapshot.error}'); // Show an error message if data fetching fails
          } else {
            var user = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 19,
                      backgroundImage: NetworkImage(user.avatars
                          .small), // Replace with the appropriate user data field for avatar URL
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              user.firstName +
                                  ' ' +
                                  user.lastName, // Replace with the appropriate user data field
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, height: 1.50),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Module', // Replace with the appropriate user data field
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(height: 1.50),
                            ),
                          ],
                        ),
                        const Text(
                          'Cool Hospital Name', // Replace with the appropriate user data field
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(height: 1.50),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () => _logout(
                          context), // Call the logout method on button press
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
