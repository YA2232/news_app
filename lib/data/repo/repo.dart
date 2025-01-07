// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:news_app/data/api/news_api.dart';
import 'package:news_app/data/model/article_model.dart';

class Repo {
  final NewsApi newsApi;
  Repo({
    required this.newsApi,
  });

  Future<List<ArticleModel>> getNewsEverything({required String query}) async {
    try {
      print(newsApi.getNewsEverything(query: query));
      return await newsApi.getNewsEverything(query: query);
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<ArticleModel>> getNewsTopHeadlines(
      {required String query}) async {
    try {
      return await newsApi.getNewsTopHeadlines(query: query);
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
