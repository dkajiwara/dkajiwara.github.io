import 'package:flutter/material.dart';
import 'package:profile/l10n/l10n.dart';
import 'package:profile/src/route.dart';
import 'package:profile/src/theme.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dkajiii',
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      routerConfig: router,
      theme: theme,
    );
  }
}

