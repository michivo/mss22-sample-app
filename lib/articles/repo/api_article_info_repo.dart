import 'dart:convert';

import 'package:flutter_articles/articles/models/article_info.dart';
import 'package:flutter_articles/articles/repo/article_info_repo.dart';
import 'package:http/http.dart' as http;

class ApiArticleInfoRepo extends ArticleInfoRepo {
  static final url =
      'https://mss-sample-service.oa.r.appspot.com/api/v1/articles';

  @override
  Future<ArticleInfo?> getByArticleNumber(String articleNumber) async {
    final response =
        await http.get(Uri.parse('${ApiArticleInfoRepo.url}/$articleNumber'));

    if (response.statusCode == 200) {
      return ArticleInfo.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load Article Info');
    }
  }
}
