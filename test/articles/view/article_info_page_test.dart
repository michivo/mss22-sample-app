// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_articles/articles/articles.dart';
import 'package:flutter_articles/articles/view/article_number_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ArticleInfoPage', () {
    testWidgets('renders ArticleNumberView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: ArticleInfoPage()));
      expect(find.byType(ArticleNumberView), findsOneWidget);
    });
  });
}
