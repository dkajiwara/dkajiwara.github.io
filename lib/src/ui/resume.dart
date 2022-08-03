import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:sketch/src/ui/view/appbar.dart';

import '../layout/adaptive.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({Key? key}) : super(key: key);

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  String _resume = "";

  Future<String> loadAssetsTextFile(String name) async {
    return await rootBundle.loadString('assets/$name');
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final isTablet = isDisplaySmallDesktop(context);

    final horizontalPadding = isTablet
        ? 160.0
        : isDesktop
            ? 440.0
            : 16.0;

    loadAssetsTextFile("resume.md").then((value) => {
          setState(() {
            _resume = value;
          })
        });

    return Scaffold(
        appBar: const MainAppBar(),
        body: Markdown(
            data: _resume,
            padding: EdgeInsets.only(
                left: horizontalPadding,
                right: horizontalPadding,
                bottom: 40)));
  }
}
