import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sketch/l10n/l10n.dart';
import 'package:sketch/resume.dart';
import 'package:url_launcher/url_launcher.dart';

import 'gen/assets.gen.dart';

void main() {
  // デフォルトで付与されるURLの「#」を取り除く.
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dkajiii',
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/resume': (context) => const ResumePage(),
      },
      theme: ThemeData(
          textTheme: GoogleFonts.zenKakuGothicNewTextTheme(
              Theme.of(context).textTheme),
          pageTransitionsTheme: PageTransitionsTheme(
              builders: kIsWeb
                  ? {
                      for (final platform in TargetPlatform.values)
                        platform: const NoTransitionsBuilder(),
                    }
                  : const {})),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(screenSize.width, 48),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    const Spacer(),
                    TextButton(
                        onPressed: () => _onTapResume(context),
                        child: const Text('Resume',
                            style: TextStyle(fontSize: 16)))
                  ],
                ),
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.only(top: 160.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(Assets.images.profileIcon.path),
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Text(
                    "Daiki Kajiwara",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "I'm a software engineer.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () => _onTapTwitter(context),
                          icon: Assets.images.icons.twitter.svg()),
                      IconButton(
                          onPressed: () => _onTapGithub(context),
                          icon: Assets.images.icons.github.svg()),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _onTapTwitter(BuildContext context) {
    final l10n = L10n.of(context)!;
    launchUrl(Uri.parse(l10n.twitter_url));
  }

  void _onTapGithub(BuildContext context) {
    final l10n = L10n.of(context)!;
    launchUrl(Uri.parse(l10n.github_url));
  }

  void _onTapResume(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/resume',
    );
  }
}

class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    // only return the child without warping it with animations
    return child!;
  }
}
