import 'package:dio/dio.dart';
import 'package:news_app/data/model/article_model.dart';
import 'package:news_app/data/model/articles_model.dart';

class NewsApi {
  String baseUrl = 'https://newsapi.org/v2/';
  String topHeadline = 'top-headlines';
  String everyThing = 'everything';
  String apiKey = '882207ef7bcf447b9e6be1f1fbbe21f0';
  late Dio dio;
  NewsApi() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 20),
    ));
  }

  Future<List<ArticleModel>> getNewsEverything({required String query}) async {
    try {
      final response = await dio.get("$everyThing?q=$query&apiKey=$apiKey");
      if (response.statusCode == 200) {
        var data = response.data;
        ArticlesModel articlesModel = ArticlesModel.fromMap(data);
        List<dynamic> listArticlesEveryThing = articlesModel.articles;
        return listArticlesEveryThing
            .map((e) => ArticleModel.fromJson(e))
            .toList();
      } else {
        print(
            'Failed to load articles with status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<ArticleModel>> getNewsTopHeadlines(
      {required String query}) async {
    try {
      final response =
          await dio.get("$topHeadline?category=$query&apiKey=$apiKey");
      if (response.statusCode == 200) {
        var data = response.data;
        ArticlesModel articlesModel = ArticlesModel.fromMap(data);
        List<dynamic> listArticlesTopHeadLine = articlesModel.articles;
        return listArticlesTopHeadLine
            .map((e) => ArticleModel.fromJson(e))
            .toList();
      } else {
        print(
            'Failed to load articles with status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
