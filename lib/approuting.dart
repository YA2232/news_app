import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/besniss_logic/cubit/news_cubit.dart';
import 'package:news_app/constant/string.dart';
import 'package:news_app/data/api/news_api.dart';
import 'package:news_app/data/model/article_model.dart';
import 'package:news_app/data/repo/repo.dart';
import 'package:news_app/presentation/screens/all_news.dart';
import 'package:news_app/presentation/screens/home_screen.dart';
import 'package:news_app/presentation/screens/search.dart';
import 'package:news_app/presentation/screens/webview_screen.dart';

class Approuting {
  late final NewsCubit newsCubit;
  late final Repo repo;

  Approuting() {
    repo = Repo(newsApi: NewsApi());
    newsCubit = NewsCubit(repo);
  }

  Route? generateRouter(RouteSettings setting) {
    switch (setting.name) {
      case homeScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: newsCubit,
                  child: HomeScreen(),
                ));
      case allNews:
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: newsCubit,
                  child: AllNews(),
                ));
      case search:
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: newsCubit,
                  child: Search(),
                ));
      case webviewscreen:
        final article = setting.arguments as ArticleModel;
        return MaterialPageRoute(
            builder: (context) => WebviewScreen(
                  url: article.url,
                ));
      default:
        return null;
    }
  }
}
