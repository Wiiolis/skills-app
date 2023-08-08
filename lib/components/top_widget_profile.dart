import 'package:demo_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_service.dart';
import '../login.dart';
import 'button.dart';

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

  _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login(apiBaseUrl: apiBaseUrl),
      ),
    );
  }

  Future<void> logoutDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            backgroundColor: AppColors.primaryColor,
            content: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.logout,
                    size: 50,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Do you want to log out?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      button(
                        text: 'Yes',
                        onClick: () => _logout(context),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      button(
                        text: 'Cancel',
                        onClick: () => Navigator.pop(context),
                      )
                    ],
                  )
                ],
              ),
            ));
      },
    );
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
                        : const Text('data'),
                    const SizedBox(width: 15),
                    Flexible(
                      flex: 100,
                      child: Column(
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
                    ),
                    Spacer(),
                    DecoratedBox(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 228, 240, 238),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: IconButton(
                        icon: const Icon(Icons.logout),
                        iconSize: 23,
                        color: AppColors.primaryColor,
                        onPressed: () => logoutDialog(),
                      ),
                    )
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