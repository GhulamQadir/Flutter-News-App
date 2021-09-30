class PopularNewsSource {
  String id;
  String name;

  PopularNewsSource({this.id, this.name});

  factory PopularNewsSource.fromJson(Map<String, dynamic> json) {
    return PopularNewsSource(id: json['id'], name: json['name']);
  }
}

class PopularNewsApi {
  PopularNewsSource popularNewsSource;
  var title;
  var author;
  var description;
  var urlToImage;
  var url;
  var publishedAt;
  var content;

  PopularNewsApi(
      {this.popularNewsSource,
      this.title,
      this.author,
      this.description,
      this.urlToImage,
      this.url,
      this.publishedAt,
      this.content});

  factory PopularNewsApi.fromJson(Map<String, dynamic> json) {
    return PopularNewsApi(
      popularNewsSource: PopularNewsSource.fromJson(json['source']),
      author: json['author'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      urlToImage: json['urlToImage'] as String,
      url: json['url'] as String,
      publishedAt: json['publishedAt'] as String,
      content: json['content'] as String,
    );
  }
}
