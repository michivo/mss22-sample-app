import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../articles.dart';

/// {@template counter_view}
/// A [StatelessWidget] which reacts to the provided
/// [ArticleInfoCubit] state and notifies it in response to user input.
/// {@endtemplate}
class ArticleDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black, width: 1.0))),
        child: BlocBuilder<ArticleInfoCubit, ArticleInfoState>(
          builder: (context, state) {
            switch (state.state) {
              case ArticleLoadingState.idle:
                return Text(
                  AppLocalizations.of(context)!.emptyData,
                  style: const TextStyle(fontSize: 20),
                );
              case ArticleLoadingState.loading:
                return const CircularProgressIndicator();
              case ArticleLoadingState.loaded:
                return Text(
                  'Article ${state.articleName} was found',
                  style: const TextStyle(fontSize: 20),
                );
              case ArticleLoadingState.notFound:
                return Text(
                  AppLocalizations.of(context)!.emptyData,
                  style: const TextStyle(fontSize: 20),
                );
            }
          },
        ));
  }
}
