import 'package:flutter/material.dart';
import 'package:flutternewsapp/models/popular-news-model.dart';
import 'package:http/http.dart' as http;
import 'package:animations/animations.dart';
import 'dart:convert';

class PopularNews extends StatefulWidget {
  @override
  _PopularNewsState createState() => _PopularNewsState();
}

class _PopularNewsState extends State<PopularNews> {
  Future<List<PopularNewsApi>> getTopStories() async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=157c9287a12840a49bc2a7d0f9228c01"));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> body = jsonData['articles'];

      List<PopularNewsApi> popularNews =
          body.map((dynamic item) => PopularNewsApi.fromJson(item)).toList();
      return popularNews;
    } else {
      throw ("Can't get the articles");
    }
  }

  goBack() {
    Navigator.of(context).pushNamed("/sports-news");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Popular News")),
        ),
        body: FutureBuilder(
            future: getTopStories(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PopularNewsApi>> snapshot) {
              if (snapshot.hasData) {
                List<PopularNewsApi> popularHeadlines = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: popularHeadlines.length,
                        itemBuilder: (context, index) => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: OpenContainer(
                                  transitionDuration: Duration(seconds: 1),
                                  transitionType:
                                      ContainerTransitionType.fadeThrough,
                                  closedBuilder: (context, action) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 300,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: popularHeadlines[
                                                                    index]
                                                                .urlToImage ==
                                                            null
                                                        ? NetworkImage(
                                                            "https://www.northampton.ac.uk/wp-content/uploads/2018/11/default-svp_news.jpg")
                                                        : NetworkImage(
                                                            popularHeadlines[
                                                                    index]
                                                                .urlToImage))),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 30),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                  popularHeadlines[index]
                                                          .popularNewsSource
                                                          .name ??
                                                      '',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                                popularHeadlines[index].title ??
                                                    ''),
                                            subtitle: Text(
                                                popularHeadlines[index]
                                                        .author ??
                                                    ''),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  openBuilder: (context, action) {
                                    return SafeArea(
                                        child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          IconButton(
                                              icon: Icon(
                                                Icons.arrow_back,
                                                color: Colors.blueAccent,
                                              ),
                                              onPressed: goBack),
                                          Container(
                                            height: 300,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: popularHeadlines[
                                                                    index]
                                                                .urlToImage ==
                                                            null
                                                        ? NetworkImage(
                                                            "https://www.northampton.ac.uk/wp-content/uploads/2018/11/default-svp_news.jpg")
                                                        : NetworkImage(
                                                            popularHeadlines[
                                                                    index]
                                                                .urlToImage))),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListTile(
                                              title: Text(
                                                popularHeadlines[index]
                                                    .popularNewsSource
                                                    .name,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.red),
                                              ),
                                              subtitle: Text(
                                                popularHeadlines[index]
                                                        .author ??
                                                    '',
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Text(
                                              popularHeadlines[index].title,
                                              style: TextStyle(fontSize: 16),
                                            )),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Text(
                                              popularHeadlines[index]
                                                      .description ??
                                                  '',
                                              style: TextStyle(fontSize: 15),
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Text(
                                              popularHeadlines[index].content ??
                                                  '',
                                              style: TextStyle(fontSize: 15),
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Text(
                                              popularHeadlines[index]
                                                      .publishedAt ??
                                                  '',
                                              style: TextStyle(fontSize: 15),
                                            )),
                                          ),
                                        ],
                                      ),
                                    ));
                                  }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
