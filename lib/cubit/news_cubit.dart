import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_states.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/services/categories_data.dart';

import '../models/article_model.dart';
import '../services/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  static List<ArticleModel> newsEverything = [];
  static List<ArticleModel> newsTopHeadlines = [];
  static List<CategoryModel> categories = getCategories();

  getNews() async {
    emit(NewsLoadingState());

    try {
      await getData();
      emit(NewsSuccessState(
          newsEverything: newsEverything,
          newsTopHeadlines: newsTopHeadlines,
          categories: categories));
    } catch (e) {
      emit(NewsFailedState(message: "FAILED IN GET DATA"));
    }
  }

  Future<void> getData() async {
    Map<String, dynamic> everythingList = await DioHelper().getNewsEverything();
    Map<String, dynamic> topHeadlinesList =
        await DioHelper().getNewsTopHeadlines();

    newsEverything = ArticleModel.convertToArticle(everythingList);
    newsTopHeadlines = ArticleModel.convertToArticle(topHeadlinesList);
  }

  changeCategories() {
    emit(NewsChangeCategoriesState());
  }
}
