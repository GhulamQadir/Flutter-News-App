import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        "https://newsapi.org/v2/everything?q=bitcoin&apiKey=157c9287a12840a49bc2a7d0f9228c01"));

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
    Navigator.of(context).pushNamed("/home");
  }

// drawer functions

  goToFavorites() async {
    FirebaseAuth.instance.currentUser == null
        ? Navigator.of(context).pushNamed("/login")
        : Navigator.of(context).pushNamed("/favorites");
  }

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

  goToLoginScreen() {
    Navigator.of(context).pushNamed("/login");
  }

  goToProfileScreen() {
    Navigator.of(context).pushNamed("/profile-screen");
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Text(
              "Headlines",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            backgroundColor: Colors.red[500],
            actions: [
              TextButton(
                  onPressed: goBack,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ))
            ]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red[500],
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.align_vertical_top_rounded,
                size: 30,
              ),
              label: "Popular",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.run_circle,
                size: 30,
              ),
              label: "Sports",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.amp_stories,
                size: 30,
              ),
              label: "Stories",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.new_label,
                size: 30,
              ),
              label: "Headlines",
            ),
          ],
          onTap: (value) {
            final routes = [
              "/home",
              "/popular-news",
              "/sports-news",
              "/top-stories",
              "/headlines",
            ];
            _currentIndex = value;
            Navigator.of(context).pushNamed(
              routes[value],
            );
          },
          currentIndex: _currentIndex,
        ),
        drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.black,
            ),
            child: Drawer(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: Container(
                        height: 35,
                        width: 140,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "News Express",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: GestureDetector(
                        onTap: FirebaseAuth.instance.currentUser == null
                            ? goToLoginScreen
                            : goToProfileScreen,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 5, left: 10),
                              child: FirebaseAuth.instance.currentUser == null
                                  ? Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    )
                                  : Text(
                                      "Profile",
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
                        onTap: goToHome,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 10),
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 10),
                              child: Text(
                                "Stories",
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                                left: 10,
                              ),
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 10),
                              child: Text(
                                "Popular",
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 10),
                              child: Text(
                                "Sports",
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
                        onTap: goToFavorites,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 10),
                              child: Text(
                                "Favorites",
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
        body: FutureBuilder(
            future: getHeadlines(),
            builder: (BuildContext context,
                AsyncSnapshot<List<HeadlinesApi>> snapshot) {
              if (snapshot.hasData) {
                List<HeadlinesApi> headlines = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [
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
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                        child: Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 250,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                                padding: const EdgeInsets.only(
                                                    left: 3),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  alignment: Alignment.topLeft,
                                                  child: ListTile(
                                                    title: Text(
                                                      headlines[index]
                                                              .headlinesSource
                                                              .name ??
                                                          '',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    trailing: IconButton(
                                                      icon: Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      ),
                                                      onPressed: () async {
                                                        var title =
                                                            headlines[index]
                                                                .title;
                                                        var description =
                                                            headlines[index]
                                                                .description;

                                                        final image =
                                                            headlines[index]
                                                                .urlToImage;

                                                        FirebaseFirestore db =
                                                            FirebaseFirestore
                                                                .instance;

                                                        FirebaseAuth.instance
                                                                    .currentUser ==
                                                                null
                                                            ? goToLoginScreen()
                                                                .pushNamed(
                                                                    "/login")
                                                            : db
                                                                .collection(
                                                                    "users")
                                                                .doc(FirebaseAuth
                                                                    .instance
                                                                    .currentUser
                                                                    .uid)
                                                                .collection(
                                                                    "posts")
                                                                .add({
                                                                "title": title,
                                                                "description":
                                                                    description,
                                                                "image": image,
                                                              });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                title: Text(
                                                  headlines[index].title ?? '',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                subtitle: Text(
                                                    headlines[index].author ??
                                                        ''),
                                              ),
                                            ],
                                          ),
                                        ),
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
