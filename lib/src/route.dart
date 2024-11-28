import 'package:go_router/go_router.dart';
import 'package:profile/src/ui/resume.dart';
import 'package:profile/src/ui/top/top_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TopPage(),
      routes: [
        GoRoute(
          path: 'resume',
          builder: (context, state) => const ResumePage(),
        ),
      ],
    ),
  ],
);
