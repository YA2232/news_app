class ArticlesModel {
  List<dynamic> articles;
  ArticlesModel({
    required this.articles,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'articles': articles,
    };
  }

  factory ArticlesModel.fromMap(Map<String, dynamic> json) {
    return ArticlesModel(
      articles: json['articles'],
    );
  }
}
