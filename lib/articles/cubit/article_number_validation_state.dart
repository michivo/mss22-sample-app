import 'package:equatable/equatable.dart';

class ArticleNumberValidationState extends Equatable {
  const ArticleNumberValidationState.valid(this.articleNumber)
      : valid = true,
        message = '';

  const ArticleNumberValidationState.invalid(this.articleNumber, this.message)
      : valid = false;

  final bool valid;
  final String message;
  final String articleNumber;

  @override
  List<Object> get props => [valid, message, articleNumber];
}
