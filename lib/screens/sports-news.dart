import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutternewsapp/models/sports-news-model.dart';
import 'package:animations/animations.dart';
import 'dart:convert';

class SportsNews extends StatefulWidget {
  @override
  _SportsNewsState createState() => _SportsNewsState();
}

class _SportsNewsState extends State<SportsNews> {
  Future<List<SportsNewsApi>> getSportsNews() async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=157c9287a12840a49bc2a7d0f9228c01"));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> body = jsonData['articles'];

      List<SportsNewsApi> sportsNews =
          body.map((dynamic item) => SportsNewsApi.fromJson(item)).toList();
      return sportsNews;
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
          title: Center(child: Text("Sports News")),
        ),
        body: FutureBuilder(
            future: getSportsNews(),
            builder: (BuildContext context,
                AsyncSnapshot<List<SportsNewsApi>> snapshot) {
              if (snapshot.hasData) {
                List<SportsNewsApi> sportsHeadlines = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Top Stories",
                      //       style: TextStyle(fontSize: 17),
                      //     ),
                      //   ],
                      // ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: sportsHeadlines.length,
                        itemBuilder: (context, index) => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text("sports"),
                            Center(
                              child: OpenContainer(
                                  // openColor: Colors.pink,
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
                                                    image: sportsHeadlines[
                                                                    index]
                                                                .urlToImage ==
                                                            null
                                                        ? NetworkImage(
                                                            "https://www.northampton.ac.uk/wp-content/uploads/2018/11/default-svp_news.jpg")
                                                        : NetworkImage(
                                                            sportsHeadlines[
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
                                                  sportsHeadlines[index]
                                                          .sportsSource
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
                                                sportsHeadlines[index].title ??
                                                    ''),
                                            subtitle: Text(
                                                sportsHeadlines[index].author ??
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
                                                    image: sportsHeadlines[
                                                                    index]
                                                                .urlToImage ==
                                                            null
                                                        ? NetworkImage(
                                                            "https://www.northampton.ac.uk/wp-content/uploads/2018/11/default-svp_news.jpg")
                                                        : NetworkImage(
                                                            sportsHeadlines[
                                                                    index]
                                                                .urlToImage))),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListTile(
                                              title: Text(
                                                sportsHeadlines[index]
                                                    .sportsSource
                                                    .name,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.red),
                                              ),
                                              subtitle: Text(
                                                sportsHeadlines[index].author ??
                                                    '',
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Text(
                                              sportsHeadlines[index].title,
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
                                              sportsHeadlines[index]
                                                      .description ??
                                                  '',
                                              style: TextStyle(fontSize: 15),
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Text(
                                              sportsHeadlines[index].content ??
                                                  '',
                                              style: TextStyle(fontSize: 15),
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Text(
                                              sportsHeadlines[index]
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
