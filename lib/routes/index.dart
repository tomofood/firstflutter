import 'package:go_router/go_router.dart';
import 'package:hm_demo/pages/home_page.dart';
import 'package:hm_demo/pages/login_page.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginPage(),
    ),
  ],
);
