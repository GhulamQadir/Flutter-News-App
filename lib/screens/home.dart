import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutternewsapp/models/everything-model.dart';
import 'package:http/http.dart' as http;
import 'package:animations/animations.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Everything>> getTopHeadlines() async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=bitcoin&apiKey=157c9287a12840a49bc2a7d0f9228c01"));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> body = jsonData['articles'];

      List<Everything> topHeadlines =
          body.map((dynamic item) => Everything.fromJson(item)).toList();
      return topHeadlines;
    } else {
      throw ("Can't get the articles");
    }
  }

  var drawerLinks = ["Top Stories", "Headlines", "Popular News", "Sports News"];
  // Map<String, dynamic> funcNames = [stories,];

// drawer functions
  goToHome() {
    Navigator.of(context).pushNamed("/home");
  }

  goToTopStories() {
    Navigator.of(context).pushNamed("/top-stories");
  }

  goToHeadlines() {
    Navigator.of(context).pushNamed("/headlines");
  }

  goToPopularNews() {
    Navigator.of(context).pushNamed("/popular-news");
  }

  goToSportsNews() {
    Navigator.of(context).pushNamed("/sports-news");
  }

  goToSignUp() {
    Navigator.of(context).pushNamed("/sign-up");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text("Home Page"), actions: [
              GestureDetector(onTap: goToSignUp, child: Text("Sign Up")),
            ]),
            drawer: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.blue,
                ),
                child: Drawer(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ListView.builder(
                        //     physics: NeverScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     itemCount: drawerLinks.length,
                        //     itemBuilder: (context, index) {
                        //       return Padding(
                        //         padding: const EdgeInsets.only(top: 20),
                        //         child: Container(
                        //             width: MediaQuery.of(context).size.width,
                        //             decoration: BoxDecoration(
                        //                 border: Border(
                        //               bottom: BorderSide(
                        //                   width: 2, color: Colors.white),
                        //             )),
                        //             child: Padding(
                        //               padding: const EdgeInsets.all(8.0),
                        //               child: Text(
                        //                 drawerLinks[index],
                        //                 style: TextStyle(
                        //                     color: Colors.white,
                        //                     fontSize: 18,
                        //                     fontWeight: FontWeight.w400),
                        //               ),
                        //             )),
                        //       );
                        //     }),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: goToHome,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom:
                                      BorderSide(width: 2, color: Colors.white),
                                )),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Home",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: goToTopStories,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom:
                                      BorderSide(width: 2, color: Colors.white),
                                )),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Top-Stories",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: goToHeadlines,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom:
                                      BorderSide(width: 2, color: Colors.white),
                                )),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Headlines",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: goToPopularNews,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom:
                                      BorderSide(width: 2, color: Colors.white),
                                )),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Popular News",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: goToSportsNews,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom:
                                      BorderSide(width: 2, color: Colors.white),
                                )),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Sports News",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),

            // appBar: AppBar(
            //   // elevation: 2,
            //   // actions: [
            //   //   Padding(
            //   //       padding: const EdgeInsets.only(top: 16, right: 5),
            //   //       child: Text(
            //   //         "SignUp",
            //   //         style: TextStyle(
            //   //           fontSize: 20,
            //   //           fontWeight: FontWeight.w400,
            //   //         ),
            //   //       )),

            //   // ],
            //   title: Center(child: Text("Home Page"),),

            // ),
            body: FutureBuilder(
                future: getTopHeadlines(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Everything>> snapshot) {
                  if (snapshot.hasData) {
                    List<Everything> everything = snapshot.data;
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
                            itemCount: everything.length,
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
                                                        image: everything[index]
                                                                    .urlToImage ==
                                                                null
                                                            ? NetworkImage(
                                                                "https://www.northampton.ac.uk/wp-content/uploads/2018/11/default-svp_news.jpg")
                                                            : NetworkImage(
                                                                everything[
                                                                        index]
                                                                    .urlToImage))),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Text(
                                                      everything[index]
                                                              .source
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
                                                    everything[index].title ??
                                                        ''),
                                                subtitle: Text(
                                                    everything[index].author ??
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
                                              Container(
                                                height: 300,
                                                width: 300,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: everything[index]
                                                                    .urlToImage ==
                                                                null
                                                            ? NetworkImage(
                                                                "https://www.northampton.ac.uk/wp-content/uploads/2018/11/default-svp_news.jpg")
                                                            : NetworkImage(
                                                                everything[
                                                                        index]
                                                                    .urlToImage))),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ListTile(
                                                  title: Text(
                                                    everything[index]
                                                        .source
                                                        .name,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.red),
                                                  ),
                                                  subtitle: Text(
                                                    everything[index].author ??
                                                        '',
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    child: Text(
                                                  everything[index].title,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    child: Text(
                                                  everything[index].description,
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    child: Text(
                                                  everything[index].content ??
                                                      '',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    child: Text(
                                                  everything[index]
                                                          .publishedAt ??
                                                      '',
                                                  style:
                                                      TextStyle(fontSize: 15),
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
                })));
  }
}
