import 'package:flutter/material.dart';

import 'articles/articles.dart';

/// {@template counter_app}
/// A [MaterialApp] which sets the `home` to [ArticleInfoView].
/// {@endtemplate}
class ArticlesApp extends MaterialApp {
  /// {@macro counter_app}
  ArticlesApp({Key? key}) : super(key: key, home: ArticleInfoView());
}
