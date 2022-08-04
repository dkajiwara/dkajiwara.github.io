import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sketch/src/ui/article/article_detail.dart';
import 'package:sketch/src/ui/view/appbar.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ArticleListState();
  }
}

class _ArticleListState extends State<ArticleList> {
  final _listItems = <ListItem>[];

  void _loadListItem() async {
    final uri = Uri.parse(
        "https://dkajiii.microcms.io/api/v1/articles?fields=id,publishedAt,title,eyecatch");
    final result = await http.get(uri, headers: {
      "X-MICROCMS-API-KEY": '4894ad22ae5342578b94a36262fa5fc09bdc'
    });
    List contents = json.decode(result.body)['contents'];
    setState(() {
      _listItems.clear();
      _listItems.addAll(contents.map((content) => ListItem.fromJSON(content)));
    });
  }

  @override
  void initState() {
    super.initState();
    _loadListItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: _listItems.map((listItem) {
          ConstrainedBox? eyecath;
          if (listItem.eyecathing != null) {
            eyecath = ConstrainedBox(
                constraints: const BoxConstraints(),
                child: Image.network(
                    "${listItem.eyecathing.toString()}?w=64&h=64&fit=crop"));
          } else {
            eyecath = null;
          }
          return Card(
            child: ListTile(
              leading: eyecath,
              title: Text(listItem.title),
              subtitle: Text(listItem.publishedAt.toIso8601String()),
              onTap: () {
                _onClickedArticle(listItem.id, context);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  void _onClickedArticle(String id, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ArticleDetail(id: id);
    }));
  }
}

class ListItem {
  final String id;
  final String title;
  final DateTime publishedAt;
  final Uri? eyecathing;

  const ListItem(
      {required this.id,
      required this.title,
      required this.publishedAt,
      required this.eyecathing});

  factory ListItem.fromJSON(Map<String, dynamic> json) {
    Uri? eyecath;
    if (json['eyecatch'] != null) {
      eyecath = Uri.parse(json['eyecatch']['url']);
    } else {
      eyecath = null;
    }

    return ListItem(
        id: json['id'],
        title: json['title'],
        publishedAt: DateTime.parse(json['publishedAt']),
        eyecathing: eyecath);
  }
}
