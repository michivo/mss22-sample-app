import 'package:bloc/bloc.dart';
import 'package:flutter_articles/articles/articles.dart';

/// {@template article_number_validation_cubit}
/// A [Cubit] which manages an [ArticleNumberValidationState] as its state.
/// {@endtemplate}
class ArticleNumberValidationCubit extends Cubit<ArticleNumberValidationState> {
  /// {@macro article_number_validation_cubit}
  ArticleNumberValidationCubit()
      : super(const ArticleNumberValidationState.invalid(
            '', 'Article Number must not be empty'));

  void check(String articleNumber, ArticleNumberType type) {
    if (articleNumber.isEmpty) {
      emit(ArticleNumberValidationState.invalid(
          articleNumber, 'Article Number must not be empty'));
      return;
    }

    if (type == ArticleNumberType.custom) {
      emit(ArticleNumberValidationState.valid(articleNumber));
      return;
    }

    if (articleNumber.length == 13) {
      if (articleNumber.contains(RegExp('\\D'))) {
        emit(ArticleNumberValidationState.invalid(
            articleNumber, 'EAN must consist of digits (0-9) only'));
      } else if (!_isCheckDigitValid(articleNumber)) {
        emit(ArticleNumberValidationState.invalid(
            articleNumber, 'Invalid check digit'));
      } else {
        emit(ArticleNumberValidationState.valid(articleNumber));
      }
    } else {
      emit(ArticleNumberValidationState.invalid(
          articleNumber, 'EAN13 must have 13 digits'));
    }
  }

  static bool _isCheckDigitValid(String ean) {
    var digits = ean.split('');
    var checkDigit = 0;
    for (var digitCount = 0; digitCount < 6; digitCount++) {
      var evenPositionDigit = int.parse(digits[2 * digitCount]);
      var oddPositionDigit = int.parse(digits[2 * digitCount + 1]);
      checkDigit += evenPositionDigit + 3 * oddPositionDigit;
    }

    checkDigit %= 10;
    if (checkDigit != 0) {
      checkDigit = 10 - checkDigit;
    }

    return int.parse(digits[12]) == checkDigit;
  }
}
