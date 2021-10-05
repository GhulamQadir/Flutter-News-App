import 'package:flutter/material.dart';
import 'package:flutternewsapp/models/headlines-model.dart';
import 'package:http/http.dart' as http;
import 'package:animations/animations.dart';
import 'dart:convert';

class Headlines extends StatefulWidget {
  @override
  _HeadlinesState createState() => _HeadlinesState();
}

class _HeadlinesState extends State<Headlines> {
  Future<List<HeadlinesApi>> getHeadlines() async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=157c9287a12840a49bc2a7d0f9228c01"));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> body = jsonData['articles'];

      List<HeadlinesApi> headlines =
          body.map((dynamic item) => HeadlinesApi.fromJson(item)).toList();
      return headlines;
    } else {
      throw ("Can't get the articles");
    }
  }

  goBack() {
    Navigator.of(context).pushNamed("/headlines");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Headlines")),
        ),
        body: FutureBuilder(
            future: getHeadlines(),
            builder: (BuildContext context,
                AsyncSnapshot<List<HeadlinesApi>> snapshot) {
              if (snapshot.hasData) {
                List<HeadlinesApi> headlines = snapshot.data;
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
                        itemCount: headlines.length,
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
                                                    image: headlines[index]
                                                                .urlToImage ==
                                                            null
                                                        ? NetworkImage(
                                                            "https://www.northampton.ac.uk/wp-content/uploads/2018/11/default-svp_news.jpg")
                                                        : NetworkImage(
                                                            headlines[index]
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
                                                  headlines[index]
                                                          .headlinesSource
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
                                                headlines[index].title ?? ''),
                                            subtitle: Text(
                                                headlines[index].author ?? ''),
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
                                                    image: headlines[index]
                                                                .urlToImage ==
                                                            null
                                                        ? NetworkImage(
                                                            "https://www.northampton.ac.uk/wp-content/uploads/2018/11/default-svp_news.jpg")
                                                        : NetworkImage(
                                                            headlines[index]
                                                                .urlToImage))),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListTile(
                                              title: Text(
                                                headlines[index]
                                                    .headlinesSource
                                                    .name,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.red),
                                              ),
                                              subtitle: Text(
                                                headlines[index].author ?? '',
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Text(
                                              headlines[index].title,
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
                                              headlines[index].description ??
                                                  '',
                                              style: TextStyle(fontSize: 15),
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Text(
                                              headlines[index].content ?? '',
                                              style: TextStyle(fontSize: 15),
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Text(
                                              headlines[index].publishedAt ??
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
