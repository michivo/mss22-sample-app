import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../articles.dart';
import 'article_info_view.dart';

/// {@template counter_page}
/// A [StatelessWidget] which is responsible for providing a
/// [ArticleNumberValidationCubit] instance to the [ArticleInfoView].
/// {@endtemplate}
class ArticleInfoPage extends StatelessWidget {
  /// {@macro counter_page}
  const ArticleInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArticleInfoView();
  }
}
