import 'package:go_router/go_router.dart';
import 'package:sketch/src/app.dart';
import 'package:sketch/src/ui/resume.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(),
      routes: [
        GoRoute(
          path: 'resume',
          builder: (context, state) => const ResumePage(),
        ),
      ],
    ),
  ],
);
