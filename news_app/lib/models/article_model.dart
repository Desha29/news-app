class ArticleModel {
  String? author;
  String title;
  String url;
  String urlImage;
  String content;
  String description;
  ArticleModel(
      {required this.title,
      required this.url,
      required this.urlImage,
      required this.content,
      required this.description});

  static List<ArticleModel> convertToArticle(Map<String, dynamic> articles) {
    List<ArticleModel> articlesList = [];
    if (articles["status"] == "ok") {
      for (var article in articles["articles"]) {
        if (article["title"] == null ||
            article["url"] == null ||
            article["urlToImage"] == null ||
            article["content"] == null ||
            article["description"] == null ) {
          continue;
        }
        articlesList.add(ArticleModel(
          title: article["title"],
          url: article["url"],
          urlImage: article["urlToImage"],
          content: article["content"],
          description: article["description"],
        ));
      }
    }
    return articlesList;
  }
}
