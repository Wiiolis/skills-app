import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_app/components/side_navigation.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/components/skill_card_list.dart';
import 'package:demo_app/components/top_widget_profile.dart';
import 'package:demo_app/components/bottom_navigation.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_service.dart';
import '../api/model/user_model.dart';
import 'documents.dart';
import '../globals.dart';
import 'info.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;
  late Future<dynamic> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _getUser();
  }

  Future<List<Widget>> pages() async {
    var user = await _userFuture;

    return [
      SkillCardList(user: user),
      const Documents(),
      Info(user: user),
    ];
  }

  dynamic apiBaseUrl = const String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://gamma.staging.candena.de',
  );

  Future<User?> _getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final box = Hive.box<User>('UserBox');
    final connectivityResult = await Connectivity().checkConnectivity();
    var token = prefs.getString('token');

    if (token != null && connectivityResult == ConnectivityResult.none) {
      int? currentUserId = prefs.getInt('currentUserId');

      // User is offline, fetch data from Hive
      final users = box.values.toList();
      if (users.isNotEmpty) {
        return users.first; // Return the first (and only) user
      } else {
        return null; // No user data available in Hive
      }
    } else if (token != null) {
      int? currentUserId = prefs.getInt('currentUserId');
      final fetchedUser = await ApiService().getUser(currentUserId);

      // Save the data to Hive
      await box.clear(); // Clear the existing data
      await box.add(fetchedUser!);

      // Return the fetched user
      return fetchedUser;
    } else {
      context.goNamed("login", queryParameters: {'apiBaseUrl': apiBaseUrl});
      return null; // No user data available (not logged in)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.05, 0.15, 0.7, 0.9],
            colors: [
              AppColors.primaryColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor,
              AppColors.backgroundColor
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              // Display mobile layout
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TopWidgetProfile(user: _userFuture),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: FutureBuilder<List<Widget>>(
                        future: pages(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            return snapshot.data![selectedIndex];
                          }
                        },
                      ),
                    ),
                  ),
                  BottomNavigation(
                    callback: (val) => setState(() => selectedIndex = val),
                  ),
                ],
              );
            } else {
              // Display tablet layout
              return Row(
                children: [
                  SideNavigation(
                      callback: (val) => setState(() => selectedIndex = val),
                      user: _userFuture),
                  Expanded(
                    child: FutureBuilder<List<Widget>>(
                      future: pages(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          return Builder(
                            builder: (BuildContext context) {
                              // Access the widget after the build phase
                              return Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child:
                                          TopWidgetProfile(user: _userFuture)),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: snapshot.data![selectedIndex],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
