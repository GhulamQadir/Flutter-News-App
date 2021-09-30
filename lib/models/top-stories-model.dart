class TopStoriesSource {
  String id;
  String name;

  TopStoriesSource({this.id, this.name});

  factory TopStoriesSource.fromJson(Map<String, dynamic> json) {
    return TopStoriesSource(id: json['id'], name: json['name']);
  }
}

class TopStoriesAPI {
  TopStoriesSource topStoriesSource;
  var title;
  var author;
  var description;
  var urlToImage;
  var url;
  var publishedAt;
  var content;

  TopStoriesAPI(
      {this.topStoriesSource,
      this.title,
      this.author,
      this.description,
      this.urlToImage,
      this.url,
      this.publishedAt,
      this.content});

  factory TopStoriesAPI.fromJson(Map<String, dynamic> json) {
    return TopStoriesAPI(
      topStoriesSource: TopStoriesSource.fromJson(json['source']),
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
