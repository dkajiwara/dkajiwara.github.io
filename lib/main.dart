import 'package:flutter/material.dart';
import 'package:sketch/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import 'gen/assets.gen.dart';

void main() {
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _onTapTwitter(BuildContext context) {
    final l10n = L10n.of(context)!;
    launchUrl(Uri.parse(l10n.twitter_url));
  }

  void _onTapGithub(BuildContext context) {
    final l10n = L10n.of(context)!;
    launchUrl(Uri.parse(l10n.github_url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}
