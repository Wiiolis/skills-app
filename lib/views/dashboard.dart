import 'package:demo_app/components/side_navigation.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/components/skill_card_list.dart';
import 'package:demo_app/components/top_widget_profile.dart';
import 'package:demo_app/components/bottom_navigation.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_service.dart';
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

  Future<dynamic> _getUser() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (token != null) {
      int? currentUserId = prefs.getInt('currentUserId');

      return ApiService().getUser(currentUserId);
    } else {
      context.goNamed("login", queryParameters: {'apiBaseUrl': apiBaseUrl});
      return null;
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
