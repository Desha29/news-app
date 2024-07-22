
import 'package:news_app/models/category_model.dart';

import '../models/article_model.dart';

abstract class NewsState {}

final class NewsInitialState extends NewsState {}

final class NewsLoadingState extends NewsState {}

final class NewsSuccessState extends NewsState {
  final List<ArticleModel> newsEverything;
  final List<ArticleModel> newsTopHeadlines;
  final List<CategoryModel> categories;
  NewsSuccessState({
    required this.newsEverything,
    required this.newsTopHeadlines,
    required this.categories,

  });
}

final class NewsFailedState extends NewsState {
  final String message;

  NewsFailedState({required this.message});
}
final class NewsChangeCategoriesState extends NewsState {}