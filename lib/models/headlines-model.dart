class HeadlinesSource {
  String id;
  String name;

  HeadlinesSource({this.id, this.name});

  factory HeadlinesSource.fromJson(Map<String, dynamic> json) {
    return HeadlinesSource(id: json['id'], name: json['name']);
  }
}

class HeadlinesApi {
  HeadlinesSource headlinesSource;
  var title;
  var author;
  var description;
  var urlToImage;
  var url;
  var publishedAt;
  var content;

  HeadlinesApi(
      {this.headlinesSource,
      this.title,
      this.author,
      this.description,
      this.urlToImage,
      this.url,
      this.publishedAt,
      this.content});

  factory HeadlinesApi.fromJson(Map<String, dynamic> json) {
    return HeadlinesApi(
      headlinesSource: HeadlinesSource.fromJson(json['source']),
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
