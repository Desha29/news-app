// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/news_states.dart';
import 'package:news_app/widgets/category_tile.dart';
import '../services/dio_helper.dart';

import '../widgets/blog_tile.dart';
import '../widgets/build_Image.dart';
import '../widgets/exception_widget.dart';
import '../widgets/loading_widget.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsLoadingState) {
          return _HomeLoadingState();
        } else if (state is NewsFailedState) {
          return _HomeFailedState(state.message);
        } else if (state is NewsSuccessState) {
          return _HomeSuccessState(
              state.newsEverything, state.newsTopHeadlines, state.categories);
        } else {
          return const ExceptionWidget(
              icon: Icons.error, message: "failed Home body state");
        }
      },
      listener: (context, state) {
        if (state is NewsChangeCategoriesState) {
          NewsCubit.get(context).getNews();
        }
      },
    );
  }
}

Widget _HomeSuccessState(List articles, List articlesTop, List categories) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 8),
            height: 80,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      DioHelper.index = index;
                      NewsCubit.get(context).changeCategories();
                    },
                    child: CategoryTile(
                      image: categories[index].image,
                      categoryName: categories[index].categoryName,
                    ),
                  );
                }),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${DioHelper.category[DioHelper.index].toUpperCase()} NEWS",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Text(
                  "View All",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CarouselSlider.builder(
              itemCount:
                  articlesTop.isEmpty ? articles.length : articlesTop.length,
              itemBuilder: (context, index, realIndex) {
                String? image = articlesTop.isEmpty
                    ? articles[index].urlImage
                    : articlesTop[index].urlImage;
                String? name = articlesTop.isEmpty
                    ? articles[index].title
                    : articlesTop[index].title;
                return buildImage(image!, index, name!, context);
              },
              options: CarouselOptions(
                  height: 250,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height)),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${DioHelper.category[DioHelper.index].toUpperCase()} NEWS",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Text(
                  "View All",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount:
                articlesTop.isEmpty ? articles.length : articlesTop.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: BlogTile(
                    title: articlesTop.isEmpty
                        ? articles[index].title
                        : articlesTop[index].title,
                    imageUrl: articlesTop.isEmpty
                        ? articles[index].urlImage
                        : articlesTop[index].urlImage,
                    description: articlesTop.isEmpty
                        ? articles[index].description
                        : articlesTop[index].description),
              );
            },
          )
        ],
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget _HomeFailedState(String message) =>
    ExceptionWidget(icon: Icons.error, message: message);

// ignore: non_constant_identifier_names
Widget _HomeLoadingState() => const LoadingWidget();
