import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:profile/src/ui/layout/layout.dart';
import 'package:profile/src/ui/view/appbar.dart';

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
    final padding = getHorizontalPadding(context);

    loadAssetsTextFile("resume.md").then((value) => {
          setState(() {
            _resume = value;
          })
        });

    return Scaffold(
        appBar: const MainAppBar(),
        body: Markdown(
            data: _resume,
            padding:
                EdgeInsets.only(left: padding, right: padding, bottom: 40)));
  }
}
