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
  late Future<dynamic> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _getUser();
  }

  dynamic apiBaseUrl = const String.fromEnvironment(
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

  Future<dynamic> _getUser() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      int? currentUserId = prefs.getInt('currentUserId');

      return ApiService().getUser(currentUserId);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(apiBaseUrl: apiBaseUrl),
        ),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<dynamic>(
            future: _userFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final user = snapshot.data;
                return Row(
                  children: [
                    user.avatars != null
                        ? CircleAvatar(
                            radius: 19,
                            backgroundImage: NetworkImage(user.avatars.small),
                          )
                        : Text('data'),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${user.firstName + ' ' + user.lastName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                height: 1.50,
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (user.clinicalRotation.groupName != null)
                              Text(
                                '${user.clinicalRotation.groupName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: const TextStyle(height: 1.50),
                              ),
                          ],
                        ),
                        if (user.clinicalRotation.hospitalName != null)
                          Text(
                            '${user.clinicalRotation.hospitalName}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: const TextStyle(height: 1.50),
                          ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () => _logout(context),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
