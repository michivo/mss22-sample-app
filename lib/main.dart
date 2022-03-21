import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';
import 'article_cubit_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(ArticlesApp()),
    blocObserver: ArticleCubitObserver(),
  );
}
