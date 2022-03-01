import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_articles/articles/articles.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ArticleNumberValidationCubit', () {
    test('initial state is invalid', () {
      expect(
          ArticleNumberValidationCubit().state,
          const ArticleNumberValidationState.invalid(
              '', 'Article Number must not be empty'));
    });

    group('valid article number', () {
      blocTest<ArticleNumberValidationCubit, ArticleNumberValidationState>(
        'emits [ArticleNumberValidationState.valid] when checking valid EAN13',
        build: ArticleNumberValidationCubit.new,
        act: (cubit) => cubit.check('1111111111116', ArticleNumberType.ean13),
        expect: () => const <ArticleNumberValidationState>[
          ArticleNumberValidationState.valid('1111111111116')
        ],
      );

      blocTest<ArticleNumberValidationCubit, ArticleNumberValidationState>(
        'emits [ArticleNumberValidationState.valid] when checking'
        ' another valid EAN13',
        build: ArticleNumberValidationCubit.new,
        act: (cubit) => cubit.check('1234567890128', ArticleNumberType.ean13),
        expect: () => const <ArticleNumberValidationState>[
          ArticleNumberValidationState.valid('1234567890128')
        ],
      );

      blocTest<ArticleNumberValidationCubit, ArticleNumberValidationState>(
        'emits [ArticleNumberValidationState.valid] when checking'
        ' valid custom number',
        build: ArticleNumberValidationCubit.new,
        act: (cubit) => cubit.check('132456A', ArticleNumberType.custom),
        expect: () => const <ArticleNumberValidationState>[
          ArticleNumberValidationState.valid('132456A')
        ],
      );
    });

    group('invalid article number', () {
      blocTest<ArticleNumberValidationCubit, ArticleNumberValidationState>(
        'emits [ArticleNumberValidationState.invalid] when checking empty ean',
        build: ArticleNumberValidationCubit.new,
        act: (cubit) => cubit.check('', ArticleNumberType.ean13),
        expect: () => const <ArticleNumberValidationState>[
          ArticleNumberValidationState.invalid(
              '', 'Article Number must not be empty')
        ],
      );

      blocTest<ArticleNumberValidationCubit, ArticleNumberValidationState>(
        'emits [ArticleNumberValidationState.invalid]'
        ' when checking empty custom number',
        build: ArticleNumberValidationCubit.new,
        act: (cubit) => cubit.check('', ArticleNumberType.custom),
        expect: () => const <ArticleNumberValidationState>[
          ArticleNumberValidationState.invalid(
              '', 'Article Number must not be empty')
        ],
      );

      blocTest<ArticleNumberValidationCubit, ArticleNumberValidationState>(
        'emits [ArticleNumberValidationState.invalid] when '
        'checking 11 digit EAN13',
        build: ArticleNumberValidationCubit.new,
        act: (cubit) => cubit.check('12345678908', ArticleNumberType.ean13),
        expect: () => const <ArticleNumberValidationState>[
          ArticleNumberValidationState.invalid(
              '12345678908', 'EAN13 must have 13 digits')
        ],
      );

      blocTest<ArticleNumberValidationCubit, ArticleNumberValidationState>(
        'emits [ArticleNumberValidationState.invalid] when checking'
        ' EAN with wrong check digit',
        build: ArticleNumberValidationCubit.new,
        act: (cubit) => cubit.check('1324567890123', ArticleNumberType.ean13),
        expect: () => const <ArticleNumberValidationState>[
          ArticleNumberValidationState.invalid(
              '1324567890123', 'Invalid check digit')
        ],
      );

      blocTest<ArticleNumberValidationCubit, ArticleNumberValidationState>(
        'emits [ArticleNumberValidationState.valid] when checking'
        ' EAN with letters in it',
        build: ArticleNumberValidationCubit.new,
        act: (cubit) => cubit.check('1324567890A23', ArticleNumberType.ean13),
        expect: () => const <ArticleNumberValidationState>[
          ArticleNumberValidationState.invalid(
              '1324567890A23', 'EAN must consist of digits (0-9) only')
        ],
      );
    });
  });
}
