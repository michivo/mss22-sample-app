import 'package:equatable/equatable.dart';

class ArticleInfoState extends Equatable {
  const ArticleInfoState.idle()
      : state = ArticleLoadingState.idle,
        articleName = '';

  const ArticleInfoState.loading()
      : state = ArticleLoadingState.loading,
        articleName = '';

  const ArticleInfoState.notFound()
      : state = ArticleLoadingState.notFound,
        articleName = '';

  const ArticleInfoState.loaded(this.articleName)
      : state = ArticleLoadingState.loaded;

  final ArticleLoadingState state;
  final String articleName;

  @override
  List<Object> get props => [state, articleName];
}

enum ArticleLoadingState { idle, loading, loaded, notFound }
