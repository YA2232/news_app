part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsEveryThingLoaded extends NewsState {
  final List<ArticleModel> listEverything;
  NewsEveryThingLoaded({required this.listEverything});
}

class SearchLoaded extends NewsState {
  final List<ArticleModel> listOfSearch;
  SearchLoaded({required this.listOfSearch});
}

class NewsTopHeadlineLoaded extends NewsState {
  final List<ArticleModel> listTopHeadline;
  NewsTopHeadlineLoaded({required this.listTopHeadline});
}

class AllNewsLoaded extends NewsState {
  final List<ArticleModel> listAllNews;
  AllNewsLoaded({required this.listAllNews});
}

class NewsError extends NewsState {
  final String message;
  NewsError({required this.message});
}
