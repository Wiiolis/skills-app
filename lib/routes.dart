import 'package:demo_app/dashboard.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      name: 'dashboard',
      path: '/',
      builder: (context, state) => Dashboard(),
    ),
  ],
);
