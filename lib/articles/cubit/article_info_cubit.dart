import 'package:bloc/bloc.dart';
import 'package:flutter_articles/articles/articles.dart';
import 'package:flutter_articles/articles/cubit/article_info_state.dart';
import 'package:flutter_articles/articles/repo/article_info_repo.dart';

/// {@template ean_validation_cubit}
/// A [Cubit] which manages an [ArticleInfoState] as its state.
/// {@endtemplate}
class ArticleInfoCubit extends Cubit<ArticleInfoState> {
  /// {@macro ean_validation_cubit}
  ArticleInfoCubit(this._repo) : super(const ArticleInfoState.idle());

  Future<void> load(String ean) async {
    emit(const ArticleInfoState.loading());

    var articleInfo = await _repo.getByArticleNumber(ean);
    if (articleInfo == null) {
      emit(const ArticleInfoState.notFound());
    } else {
      emit(ArticleInfoState.loaded(articleInfo.name));
    }
  }

  void reset() {
    emit(const ArticleInfoState.idle());
  }

  final ArticleInfoRepo _repo;
}
