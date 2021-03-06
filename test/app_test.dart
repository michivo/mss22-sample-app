// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_articles/app.dart';
import 'package:flutter_articles/articles/view/article_info_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ArticlesApp', () {
    testWidgets('is a MaterialApp', (tester) async {
      expect(ArticlesApp(), isA<MaterialApp>());
    });

    testWidgets('home is ArticleInfoPage', (tester) async {
      expect(ArticlesApp().home, isA<ArticleInfoView>());
    });

    testWidgets('renders ArticleInfoPage', (tester) async {
      await tester.pumpWidget(ArticlesApp());
      expect(find.byType(ArticleInfoView), findsOneWidget);
    });
  });
}
