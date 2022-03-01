import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../articles.dart';
import 'article_number_view.dart';

/// {@template counter_view}
/// A [StatefulWidget] which reacts to the provided
/// [ArticleNumberValidationCubit] state and notifies it in response to user input.
/// {@endtemplate}
class ArticleInfoView extends StatefulWidget {
  @override
  _ArticleInfoViewState createState() => _ArticleInfoViewState();
}

class _ArticleInfoViewState extends State<ArticleInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Article Info')),
      body: Center(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ArticleNumberValidationCubit>(
                create: (context) => ArticleNumberValidationCubit()),
            BlocProvider<ArticleInfoCubit>(
                create: (context) =>
                    ArticleInfoCubit(InMemoryArticleInfoRepo())),
          ],
          child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(children: [
                ArticleNumberView(),
                Container(
                  margin: const EdgeInsets.all(15),
                  child: BlocBuilder<ArticleNumberValidationCubit,
                      ArticleNumberValidationState>(
                    buildWhen: (oldState, newState) {
                      return oldState.valid != newState.valid ||
                          (newState.valid &&
                              oldState.articleNumber != newState.articleNumber);
                    },
                    builder: (validationContext, validationState) {
                      return BlocBuilder<ArticleInfoCubit, ArticleInfoState>(
                        builder: (infoContext, infoState) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(250, 60),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: validationState.valid
                                ? () {
                                    infoContext
                                        .read<ArticleInfoCubit>()
                                        .load(validationState.articleNumber);
                                  }
                                : null,
                            child: const Text(
                              'Search Article',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                ArticleDetailsView()
              ])),
        ),
      ),
    );
  }

  String toDisplayValue(ArticleNumberType state) {
    switch (state) {
      case ArticleNumberType.custom:
        return 'Custom';
      case ArticleNumberType.ean13:
        return 'EAN 13';
      default:
        throw Exception('Invalid Ean Type $state');
    }
  }
}
