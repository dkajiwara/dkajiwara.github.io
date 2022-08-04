import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sketch/src/data/article/articles_data_source.dart';

import '../../ui/article/articles.dart';

final articlesRepositoryProvider = Provider<ArticlesRepository>((ref) =>
    ArticlesDataRepository(dataSource: ref.read(articlesDataSourceProvider)));

abstract class ArticlesRepository {
  Future<List<ListItem>> getArticles();
}

class ArticlesDataRepository implements ArticlesRepository {
  final ArticlesDataSource _dataSource;
  ArticlesDataRepository({required ArticlesDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<List<ListItem>> getArticles() {
    return _dataSource.getArticles();
  }
}
