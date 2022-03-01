import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_articles/articles/articles.dart';
import 'package:flutter_articles/articles/view/article_info_view.dart';
import 'package:flutter_articles/articles/view/article_number_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockArticleNumberValidationCubit
    extends MockCubit<ArticleNumberValidationState>
    implements ArticleNumberValidationCubit {}

void main() {
  late ArticleNumberValidationCubit eanValidationCubit;

  setUp(() {
    eanValidationCubit = MockArticleNumberValidationCubit();
  });

  group('ArticleNumberValidationView', () {
    testWidgets('renders current EanValidationCubit state', (tester) async {
      when(() => eanValidationCubit.state).thenReturn(
          const ArticleNumberValidationState.invalid('123', 'Bad code'));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: eanValidationCubit,
              child: ArticleNumberView(),
            ),
          ),
        ),
      );
      expect(find.text('Bad code'), findsOneWidget);
    });
  });
}
