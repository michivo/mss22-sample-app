import 'package:equatable/equatable.dart';

class ArticleInfo extends Equatable {
  const ArticleInfo({required this.name, required this.description});

  ArticleInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        description = json['description'] as String;

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'name': name, 'description': description};

  final String name;
  final String description;

  @override
  List<Object> get props => [name, description];
}
