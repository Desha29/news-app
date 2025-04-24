import 'package:dio/dio.dart';

class DioHelper {
  Dio dio = Dio();
 static List<String> category = [
    "business",
    "entertainment",
    "general",
    "health",
    "sports",
    "technology"
  ];
  static int index = 0;
  Future<Map<String, dynamic>> getNewsEverything() async {
    Response response = await dio.get(
        'https://newsapi.org/v2/everything?q=bitcoin&apiKey=ed0fd4fe74294abc847511f12350bf3b');

    return response.data;
  }

  Future<Map<String, dynamic>> getNewsTopHeadlines() async {
    Response response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&category=${category[index]}&apiKey=ed0fd4fe74294abc847511f12350bf3b');
    print(response.data);
    return response.data;
  }
}


