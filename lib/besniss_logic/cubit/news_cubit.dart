// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/data/model/article_model.dart';
import 'package:news_app/data/repo/repo.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final Repo repo;
  NewsCubit(this.repo) : super(NewsInitial());

  Future<void> getNewsEverything(String query) async {
    emit(NewsLoading());
    try {
      final listEverything = await repo.getNewsEverything(query: query);
      emit(NewsEveryThingLoaded(listEverything: listEverything));
    } catch (e) {
      emit(NewsError(message: e.toString()));
    }
  }

  Future<void> searchNews(String query) async {
    emit(NewsLoading());
    try {
      final listOfSearch = await repo.getNewsEverything(query: query);
      emit(SearchLoaded(listOfSearch: listOfSearch));
    } catch (e) {
      emit(NewsError(message: e.toString()));
    }
  }

  void clearSearch() {
    emit(SearchLoaded(listOfSearch: []));
  }

  Future<void> getNewsTopHeadlines(String query) async {
    emit(NewsLoading());
    try {
      final listTopHeadline = await repo.getNewsTopHeadlines(query: query);
      emit(NewsTopHeadlineLoaded(listTopHeadline: listTopHeadline));
    } catch (e) {
      emit(NewsError(message: e.toString()));
    }
  }

  Future<void> getAllNews(String query) async {
    emit(NewsLoading());
    try {
      final listAllNews = await repo.getNewsEverything(query: query);
      emit(AllNewsLoaded(listAllNews: listAllNews));
    } catch (e) {
      emit(NewsError(message: e.toString()));
    }
  }
}
