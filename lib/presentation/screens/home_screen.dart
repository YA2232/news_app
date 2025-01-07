import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/besniss_logic/cubit/news_cubit.dart';
import 'package:news_app/constant/appColor.dart';
import 'package:news_app/constant/string.dart';
import 'package:news_app/data/model/article_model.dart';
import 'package:news_app/main.dart';
import 'package:news_app/presentation/widget/card_category_news.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  String selectedCategory = "business";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsCubit>(context).getNewsTopHeadlines(selectedCategory);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    BlocProvider.of<NewsCubit>(context).getNewsTopHeadlines(selectedCategory);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      MyApp.routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    MyApp.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "NEWS",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(search);
              },
              icon: Icon(Icons.search, color: Colors.white),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 20),
                _buildCategories(),
                SizedBox(height: 20),
                _buildTopHeadlines(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refreshData() async {
    await BlocProvider.of<NewsCubit>(context)
        .getNewsTopHeadlines(selectedCategory);
    await BlocProvider.of<NewsCubit>(context)
        .getNewsEverything("Breaking News");
  }

  Widget _buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryButton("sport"),
          _buildCategoryButton("business"),
          _buildCategoryButton("technology"),
          _buildCategoryButton("science"),
          _buildCategoryButton("health"),
          _buildCategoryButton("general"),
          _buildCategoryButton("entertainment"),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String categoryName) {
    bool isSelected = selectedCategory == categoryName;
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedCategory = categoryName;
          });
          BlocProvider.of<NewsCubit>(context).getNewsTopHeadlines(categoryName);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColor().primary : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColor().primary : Colors.grey.shade400,
              width: 2,
            ),
          ),
          child: Text(
            categoryName,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "LATEST NEWS",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(allNews);
          },
          child: Row(
            children: [
              Text("See All", style: TextStyle(color: AppColor().secondary)),
              Icon(Icons.arrow_forward, color: AppColor().secondary, size: 18),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopHeadlines() {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is NewsError) {
          return Center(child: Text(state.message.toString()));
        } else if (state is NewsTopHeadlineLoaded) {
          List<ArticleModel> list = state.listTopHeadline ?? [];
          if (list.isEmpty) {
            return Center(child: Text("No Top Headlines found"));
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, i) {
              return CardCategoryNews(articleModel: list[i]);
            },
          );
        }
        return Center(child: Text("No Headlines Found"));
      },
    );
  }
}
