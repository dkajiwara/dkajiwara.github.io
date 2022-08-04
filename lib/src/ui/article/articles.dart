import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sketch/src/domain/article/articles_repository.dart';
import 'package:sketch/src/ui/view/appbar.dart';

import 'article_detail.dart';

class ArticleList extends HookConsumerWidget {
  const ArticleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(articlesViewModelNotifierProvider);

    useEffect(() {
      final subscription = viewModel.navigateToArticle.stream.listen((event) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ArticleDetail(id: event);
        }));
      });
      return subscription.cancel;
    }, [viewModel.navigateToArticle.stream]);

    return Scaffold(
      appBar: const MainAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: viewModel.items.map((listItem) {
          ConstrainedBox? eyecatch;
          if (listItem.eyecathing != null) {
            eyecatch = ConstrainedBox(
                constraints: const BoxConstraints(),
                child: Image.network(
                    "${listItem.eyecathing.toString()}?w=64&h=64&fit=crop"));
          } else {
            eyecatch = null;
          }
          return Card(
            child: ListTile(
              leading: eyecatch,
              title: Text(listItem.title),
              subtitle: Text(listItem.publishedAt.toIso8601String()),
              onTap: () {
                viewModel.onClickedArticle(listItem.id);
              },
            ),
          );
        }).toList(),
      ),
    );
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

final articlesViewModelNotifierProvider = ChangeNotifierProvider.autoDispose(
    (ref) =>
        ArticlesViewModel(repository: ref.read(articlesRepositoryProvider)));

class ArticlesViewModel extends ChangeNotifier {
  ArticlesRepository repository;
  List<ListItem> _items = List.empty();

  List<ListItem> get items => _items;

  final _navigateToArticle = StreamController<String>();

  StreamController<String> get navigateToArticle => _navigateToArticle;

  ArticlesViewModel({required ArticlesRepository this.repository}) {
    _fetchArticles();
  }

  @override
  void dispose() {
    _navigateToArticle.close();
    super.dispose();
  }

  void _fetchArticles() async {
    repository
        .getArticles()
        .then((value) => {_items = value})
        .whenComplete(() => notifyListeners());
  }

  void onClickedArticle(String id) {
    _navigateToArticle.sink.add(id);
  }
}
