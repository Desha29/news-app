// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../services/categories_data.dart';
import '../services/news_data.dart';
import '../models/category_model.dart';
import '../widgets/blog_tile.dart';
import '../widgets/category_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  List<ArticleModel> articlesTop = [];

  bool loading = true;
  @override
  void initState() {
    categories = getCategories();

    getNews();
    super.initState();
  }

  getNews() async {
    NewsData newsData = NewsData();
    await newsData.getData();
    articles = NewsData.newsEverything;
     articlesTop = NewsData.newsTopHeadlines;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "News",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "App",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
            ))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    height: 80,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              setState(() {
                                DioHelper.index = index;
                              });
                              await getNews();
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
                      itemCount: articlesTop.isEmpty? articles.length :articlesTop.length,
                      itemBuilder: (context, index, realIndex) {
                        String? image = articlesTop.isEmpty?articles[index].urlImage :articlesTop[index].urlImage;
                        String? name = articlesTop.isEmpty? articles[index].title:articlesTop[index].title;
                        return buildImage(image, index, name);
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
                    itemCount: articlesTop.isEmpty? articles.length :articlesTop.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                      
                        child: BlogTile(
                            title: articlesTop.isEmpty? articles[index].title:articlesTop[index].title,
                            imageUrl: articlesTop.isEmpty?articles[index].urlImage :articlesTop[index].urlImage,
                            description: articlesTop.isEmpty?articles[index].description :articlesTop[index].description),
                      );
                    },
                  )
                ],
              ),
            ),
    );
  }

  Widget buildImage(String image, int index, String name) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                    imageUrl: image,
                    height: 250,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width)),
            Container(
              height: 250,
              padding: const EdgeInsets.only(left: 10),
              margin: const EdgeInsets.only(top: 170),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Text(
                name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      );
}
