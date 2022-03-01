import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../articles.dart';

/// {@template counter_view}
/// A [StatefulWidget] which reacts to the provided
/// [ArticleNumberValidationCubit] state and notifies it in response to user
/// input.
/// {@endtemplate}
class ArticleNumberView extends StatefulWidget {
  ArticleNumberView();

  @override
  _ArticleNumberViewState createState() => _ArticleNumberViewState();
}

class _ArticleNumberViewState extends State<ArticleNumberView> {
  ArticleNumberType type = ArticleNumberType.custom;
  String value = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleNumberValidationCubit,
        ArticleNumberValidationState>(
      builder: (context, state) {
        return Container(
            margin: const EdgeInsets.all(10),
            child: Column(children: [
              DropdownButtonFormField<ArticleNumberType>(
                value: type,
                onChanged: (newType) {
                  type = newType!;
                  context
                      .read<ArticleNumberValidationCubit>()
                      .check(value, type);
                },
                items: <ArticleNumberType>[
                  ArticleNumberType.custom,
                  ArticleNumberType.ean13
                ]
                    .map<DropdownMenuItem<ArticleNumberType>>(
                        (v) => DropdownMenuItem<ArticleNumberType>(
                              value: v,
                              child: Text(toDisplayValue(v)),
                            ))
                    .toList(),
                decoration: const InputDecoration(
                  label: Text('Article Number Type'),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
                alignment: Alignment.center,
              ),
              TextFormField(
                onChanged: (newValue) {
                  value = newValue;
                  context
                      .read<ArticleNumberValidationCubit>()
                      .check(value, type);
                },
                style: const TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                    hintText: 'Enter an Article Number',
                    label: const Text('Article Number'),
                    filled: true,
                    fillColor:
                        state.valid ? Colors.white : Colors.red.shade100),
              ),
              Text(state.message),
            ]));
      },
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
