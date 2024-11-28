import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:profile/gen/assets.gen.dart';
import 'package:profile/src/ui/layout/layout.dart';
import 'package:profile/src/ui/view/appbar.dart';
import 'package:profile/src/util/link.dart';
import 'package:url_launcher/url_launcher.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    final horizontalPadding = getHorizontalPadding(context);

    return Scaffold(
      appBar: const MainAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 160),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(Assets.images.profileIcon.path),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Daiki Kajiwara",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "I'm a software engineer.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _onTapResume,
              child: const Text(
                'Resume',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _onTapTwitter,
                  icon: Assets.images.icons.twitter.svg(),
                ),
                IconButton(
                  onPressed: _onTapGithub,
                  icon: Assets.images.icons.github.svg(),
                ),
                IconButton(
                  onPressed: _onTapBlog,
                  icon: Assets.images.icons.globe.svg(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
          ],
        ),
      ),
    );
  }

  void _onTapTwitter() {
    _trackEvent("Twitter");
    launchUrl(Uri.parse(Link.twitter));
  }

  void _onTapGithub() {
    _trackEvent("Github");
    launchUrl(Uri.parse(Link.github));
  }

  void _onTapResume() {
    _trackEvent("職務経歴書");
    context.push('/resume');
  }

  void _onTapBlog() {
    _trackEvent("ブログ");
    launchUrl(Uri.parse(Link.hatena));
  }

  void _trackEvent(String name) async {
    unawaited(FirebaseAnalytics.instance.logEvent(name: name));
  }
}
