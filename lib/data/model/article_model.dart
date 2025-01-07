// ignore_for_file: public_member_api_docs, sort_constructors_first
class ArticleModel {
  String id;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  String name;
  String publishedAt;
  ArticleModel({
    required this.id,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
    required this.name,
    required this.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] ?? '',
      author: json['author'] ?? 'Unknown',
      publishedAt: json['publishedAt'] ?? 'Unknown',
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      content: json['content'] ?? '',
      name: json['name'] ?? 'No Name',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'content': content,
      'publishedAt': publishedAt,
      'name': name,
    };
  }
}
