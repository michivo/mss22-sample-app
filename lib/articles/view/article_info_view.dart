import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../../l10n/l10n.dart';
import '../../l10n/locale_provider.dart';
import '../Widgets/language_drop_down.dart';
import '../articles.dart';
import '../repo/api_article_info_repo.dart';
import 'article_number_view.dart';

/// {@template counter_view}
/// A [StatefulWidget] which reacts to the provided
/// [ArticleNumberValidationCubit] state and notifies it in response to user
/// input.
/// {@endtemplate}
class ArticleInfoView extends StatefulWidget {
  @override
  _ArticleInfoViewState createState() => _ArticleInfoViewState();
}

class _ArticleInfoViewState extends State<ArticleInfoView> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);

          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            locale: provider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
            initialRoute: '/',
          );
        },
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Info'),
        actions: [
          LanguagePickerWidget(),
          const SizedBox(width: 12),
        ],
      ),
      body: Center(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ArticleNumberValidationCubit>(
                create: (context) => ArticleNumberValidationCubit()),
            BlocProvider<ArticleInfoCubit>(
                create: (context) => ArticleInfoCubit(ApiArticleInfoRepo())),
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
                            child: Text(
                              AppLocalizations.of(context)!.searchArticle,
                              style: const TextStyle(
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
