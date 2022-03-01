import 'package:flutter_articles/articles/models/article_info.dart';
import 'package:flutter_articles/articles/repo/article_info_repo.dart';

class InMemoryArticleInfoRepo extends ArticleInfoRepo {
  @override
  Future<ArticleInfo?> getByArticleNumber(String articleNumber) {
    if (articleNumber == '1234567890128') {
      return Future<ArticleInfo?>.delayed(const Duration(seconds: 1)).then(
          (onValue) =>
              const ArticleInfo(name: 'Milch', description: 'Mantscha Müch'));
    }
    if (articleNumber == '1111111111116') {
      return Future<ArticleInfo?>.delayed(const Duration(seconds: 1)).then(
          (onValue) => const ArticleInfo(
              name: 'Joghurt', description: 'Mantscha Joghurt'));
    }

    return Future<ArticleInfo?>.delayed(const Duration(seconds: 1))
        .then((onValue) => null);
  }
}
