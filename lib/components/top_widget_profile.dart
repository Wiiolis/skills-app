import 'package:demo_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_service.dart';
import 'button.dart';

class TopWidgetProfile extends StatefulWidget {
  final user;

  const TopWidgetProfile({Key? key, required this.user}) : super(key: key);

  @override
  _TopWidgetProfileState createState() => _TopWidgetProfileState();
}

class _TopWidgetProfileState extends State<TopWidgetProfile> {
  @override
  void initState() {
    super.initState();
  }

  dynamic apiBaseUrl = const String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://gamma.staging.candena.de',
  );

  _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    context.goNamed("login", queryParameters: {'apiBaseUrl': apiBaseUrl});
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
                      Button(
                        text: 'Yes',
                        onClick: () => _logout(context),
                        theme: 'light',
                        radius: 'semiround',
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Button(
                        text: 'Cancel',
                        onClick: () => Navigator.pop(context),
                        theme: 'light',
                        radius: 'semiround',
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
            future: widget.user,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final user = snapshot.data;
                return Row(
                  children: [
                    user.avatars != null && user.avatars.small != null
                        ? CircleAvatar(
                            radius: 19,
                            backgroundImage: NetworkImage(user.avatars.small),
                          )
                        : const Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 40,
                          ),
                    const SizedBox(width: 15),
                    Flexible(
                      flex: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${user.firstName ?? ''} ${user.lastName ?? ''}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  height: 1.50,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                user.clinicalRotation.groupName ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: const TextStyle(height: 1.50),
                              ),
                            ],
                          ),
                          Text(
                            user.clinicalRotation.hospitalName ??
                                "No Hospital Info",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: const TextStyle(height: 1.50),
                          )
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
