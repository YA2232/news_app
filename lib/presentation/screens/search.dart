import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/besniss_logic/cubit/news_cubit.dart';
import 'package:news_app/data/model/article_model.dart';
import 'package:news_app/presentation/widget/card_category_news.dart';

class Search extends StatefulWidget {
  Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController text = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    text.dispose();
  }

  void _searchNews() {
    final query = text.text.trim();
    if (query.isNotEmpty) {
      BlocProvider.of<NewsCubit>(context).searchNews(query);
      FocusScope.of(context).unfocus();
    }
  }

  Future<bool> onPop() async {
    BlocProvider.of<NewsCubit>(context).clearSearch();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onPop,
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: text,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: _searchNews,
                icon: Icon(Icons.search),
              ),
              hintText: "search",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        body: _buildNewsCards(),
      ),
    );
  }

  Widget _buildNewsCards() {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is NewsError) {
          return Center(child: Text(state.message.toString()));
        } else if (state is SearchLoaded) {
          List<ArticleModel> list = state.listOfSearch ?? [];
          if (list.isEmpty) {
            return Center(child: Text("No articles founded"));
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              return CardCategoryNews(articleModel: list[i]);
            },
          );
        }
        return Center(child: Text("No articles founded"));
      },
    );
  }
}
