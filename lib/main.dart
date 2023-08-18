import 'dart:convert';
import 'package:demo_app/components/skill_card_list.dart';
import 'package:demo_app/views/documents.dart';
import 'package:demo_app/views/skill_detail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'views/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/info.dart';
import 'views/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const apiBaseUrl = String.fromEnvironment('API_BASE_URL',
      defaultValue: 'https://gamma.staging.candena.de');

  final userData = await _getUserData();

  runApp(MyApp(apiBaseUrl: apiBaseUrl, userData: userData));
}

Future<Map<String, dynamic>?> _getUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final userDataJson = prefs.getString('userData');
  if (userDataJson != null) {
    return jsonDecode(userDataJson) as Map<String, dynamic>;
  }
  return null;
}

class MyApp extends StatelessWidget {
  final String apiBaseUrl;
  final Map<String, dynamic>? userData; // Modify the userData parameter

  MyApp({Key? key, required this.apiBaseUrl, this.userData}) : super(key: key);

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const Dashboard(),
      ),
      GoRoute(
        path: "/skill-list",
        builder: (context, state) => const SkillCardList(
          user: [],
        ),
      ),
      GoRoute(
          name: "skillDetail",
          path: '/skill-list/:moduleVersionId/clinical-skills/:skillId',
          builder: (context, state) => SkillDetail(
                level: state.uri.queryParameters['level'],
                moduleVersionId:
                    int.tryParse(state.pathParameters['moduleVersionId']!) ?? 0,
                skillId: int.tryParse(state.pathParameters['skillId']!) ?? 0,
              )),
      GoRoute(
        path: "/documents",
        builder: (context, state) => const Documents(),
      ),
      GoRoute(
        path: "/info",
        builder: (context, state) => Info(user: const []),
      ),
      GoRoute(
        name: 'login',
        path: "/login",
        builder: (context, state) {
          final query = state.uri.queryParameters['apiBaseUrl'].toString();
          return Login(apiBaseUrl: query);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp.router(
          routerConfig: _router, debugShowCheckedModeBanner: false),
    );
  }
}
