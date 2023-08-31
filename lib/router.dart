import 'package:go_router/go_router.dart';

import 'components/skill_card_list.dart';
import 'views/dashboard.dart';
import 'views/documents.dart';
import 'views/info.dart';
import 'views/login.dart';
import 'views/skill_detail.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: 'login',
      path: "/",
      builder: (context, state) {
        final query = state.uri.queryParameters['apiBaseUrl'].toString();
        return Login(apiBaseUrl: query);
      },
    ),
    GoRoute(
      name: 'home',
      path: "/home",
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
              instructorId:
                  int.tryParse(state.uri.queryParameters['instructorId']!),
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
  ],
);
