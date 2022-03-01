import 'package:flutter/material.dart';

import 'articles/articles.dart';

/// {@template counter_app}
/// A [MaterialApp] which sets the `home` to [ArticleInfoPage].
/// {@endtemplate}
class ArticlesApp extends MaterialApp {
  /// {@macro counter_app}
  const ArticlesApp({Key? key})
      : super(key: key, home: const ArticleInfoPage());
}
