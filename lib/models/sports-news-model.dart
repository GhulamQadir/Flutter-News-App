class SportsSource {
  String id;
  String name;

  SportsSource({this.id, this.name});

  factory SportsSource.fromJson(Map<String, dynamic> json) {
    return SportsSource(id: json['id'], name: json['name']);
  }
}

class SportsNewsApi {
  SportsSource sportsSource;
  var title;
  var author;
  var description;
  var urlToImage;
  var url;
  var publishedAt;
  var content;

  SportsNewsApi(
      {this.sportsSource,
      this.title,
      this.author,
      this.description,
      this.urlToImage,
      this.url,
      this.publishedAt,
      this.content});

  factory SportsNewsApi.fromJson(Map<String, dynamic> json) {
    return SportsNewsApi(
      sportsSource: SportsSource.fromJson(json['source']),
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
