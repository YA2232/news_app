import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/besniss_logic/cubit/news_cubit.dart';
import 'package:news_app/constant/appColor.dart';
import 'package:news_app/data/model/article_model.dart';
import 'package:news_app/presentation/widget/card_category_news.dart';

class AllNews extends StatefulWidget {
  const AllNews({super.key});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NewsCubit>(context).getAllNews("Breaking News");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor().secondary,
        title: Text(
          "ALL NEWS",
          style: TextStyle(
              color: AppColor().tertiary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(child: _buildAllNews()),
    );
  }
}

Widget _buildAllNews() {
  return BlocBuilder<NewsCubit, NewsState>(
    builder: (context, state) {
      if (state is NewsLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is NewsError) {
        return Center(child: Text(state.message.toString()));
      } else if (state is AllNewsLoaded) {
        List<ArticleModel> list = state.listAllNews ?? [];
        if (list.isEmpty) {
          return Center(child: Text("No Articles found"));
        }
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, i) {
            return CardCategoryNews(articleModel: list[i]);
          },
        );
      }
      return Center(child: Text("Wrong"));
    },
  );
}
