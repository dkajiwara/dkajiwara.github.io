import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:profile/src/ui/article/articles.dart';

final articlesDataSourceProvider =
    Provider<ArticlesDataSource>((ref) => RemoteArticlesDataSource());

abstract class ArticlesDataSource {
  Future<List<ListItem>> getArticles();
}

class RemoteArticlesDataSource implements ArticlesDataSource {
  @override
  Future<List<ListItem>> getArticles() async {
    final uri = Uri.parse(
        "https://dkajiii.microcms.io/api/v1/articles?fields=id,publishedAt,title,eyecatch");
    final result = await http.get(uri, headers: {
      "X-MICROCMS-API-KEY": '4894ad22ae5342578b94a36262fa5fc09bdc'
    });

    List contents = json.decode(result.body)['contents'];
    final items =
        contents.map((content) => ListItem.fromJSON(content)).toList();
    return items;
  }
}
