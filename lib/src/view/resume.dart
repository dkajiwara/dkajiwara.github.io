import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

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
    var screenSize = MediaQuery.of(context).size;
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
                        onPressed: () => {
                              // ignore.
                            },
                        child: const Text('Resume',
                            style: TextStyle(fontSize: 16)))
                  ],
                ),
              ),
            )),
        body: Markdown(
            data: _resume,
            padding: EdgeInsets.only(
                left: horizontalPadding,
                right: horizontalPadding,
                bottom: 40)));
  }
}
