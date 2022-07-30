import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetail extends StatefulWidget {
  final String id;

  const ArticleDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ArticleDetailState();
  }
}

class _ArticleDetailState extends State<ArticleDetail> {
  Map<String, dynamic>? item;

  void _loadDetail(String id) async {
    final result = await http.get(
        Uri.parse('https://dkajiii.microcms.io/api/v1/articles/$id'),
        headers: {
          "X-MICROCMS-API-KEY": '4894ad22ae5342578b94a36262fa5fc09bdc'
        });
    setState(() {
      item = json.decode(result.body);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: item != null
          ? WebView(
              initialUrl: 'about:blank',
              onWebViewCreated: (webViewController) {
                webViewController.loadUrl(Uri.dataFromString(item!['content'],
                        mimeType: 'text/html', encoding: utf8)
                    .toString());
              },
            )
          : const Center(child: Text('読み込み中')),
    );
  }
}
