import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sketch/l10n/l10n.dart';
import 'package:sketch/src/ui/article/articles.dart';
import 'package:sketch/src/ui/resume.dart';
import 'package:sketch/src/ui/view/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../gen/assets.gen.dart';
import 'ui/layout/layout.dart';

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
        '/articles': (context) => const ArticleList()
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
    final padding = getHorizontalPadding(context);

    return Scaffold(
        appBar: const MainAppBar(),
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
                Padding(
                  padding:
                      EdgeInsets.only(top: 40.0, left: padding, right: padding),
                  child: const Text(
                    "Daiki Kajiwara",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 20.0, left: padding, right: padding),
                  child: const Text(
                    "I'm a software engineer.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 20.0, left: padding, right: padding),
                  child: TextButton(
                      onPressed: () => _onTapResume(context),
                      child: const Text('Resume',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700))),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 20.0, left: padding, right: padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () => _onTapTwitter(context),
                          icon: Assets.images.icons.twitter.svg()),
                      IconButton(
                          onPressed: () => _onTapGithub(context),
                          icon: Assets.images.icons.github.svg()),
                      IconButton(
                          onPressed: () => _onTapBlog(context),
                          icon: Assets.images.icons.globe.svg()),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 20.0, left: padding, right: padding),
                  child: const Divider(),
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
    Navigator.pushNamed(context, '/resume');
  }

  void _onTapBlog(BuildContext context) {
    final l10n = L10n.of(context)!;
    launchUrl(Uri.parse(l10n.hatena_url));
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
