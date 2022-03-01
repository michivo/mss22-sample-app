import 'package:flutter_articles/articles/articles.dart';

abstract class ArticleInfoRepo {
  Future<ArticleInfo?> getByArticleNumber(String articleNumber);
}
