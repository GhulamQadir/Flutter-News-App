import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutternewsapp/models/top-stories-model.dart';
import 'package:http/http.dart' as http;
import 'package:animations/animations.dart';
import 'dart:convert';

class TopStories extends StatefulWidget {
  @override
  _TopStoriesState createState() => _TopStoriesState();
}

class _TopStoriesState extends State<TopStories> {
  Future<List<TopStoriesAPI>> getTopStories() async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=Apple&from=2021-09-30&sortBy=popularity&apiKey=157c9287a12840a49bc2a7d0f9228c01"));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> body = jsonData['articles'];

      List<TopStoriesAPI> topStories =
          body.map((dynamic item) => TopStoriesAPI.fromJson(item)).toList();
      return topStories;
    } else {
      throw ("Can't get the articles");
    }
  }

  goBack() {
    Navigator.of(context).pushNamed("/bottom");
  }

// drawer functions

  goToFavorites() async {
    FirebaseAuth.instance.currentUser == null
        ? Navigator.of(context).pushNamed("/login")
        : Navigator.of(context).pushNamed("/favorites");
  }

  goToHome() {
    Navigator.of(context).pushNamed("/bottom");
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Text(
              "Stories",
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
        drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.red[500],
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
                            color: Colors.black,
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
                  ],
                ),
              ),
            )),
        body: FutureBuilder(
            future: getTopStories(),
            builder: (BuildContext context,
                AsyncSnapshot<List<TopStoriesAPI>> snapshot) {
              if (snapshot.hasData) {
                List<TopStoriesAPI> storiesHeadlines = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: storiesHeadlines.length,
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
                                                        image: storiesHeadlines[
                                                                        index]
                                                                    .urlToImage ==
                                                                null
                                                            ? NetworkImage(
                                                                "https://www.northampton.ac.uk/wp-content/uploads/2018/11/default-svp_news.jpg")
                                                            : NetworkImage(
                                                                storiesHeadlines[
                                                                        index]
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
                                                      storiesHeadlines[index]
                                                              .topStoriesSource
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
                                                        var name =
                                                            storiesHeadlines[
                                                                    index]
                                                                .topStoriesSource
                                                                .name;
                                                        var author =
                                                            storiesHeadlines[
                                                                    index]
                                                                .author;
                                                        var content =
                                                            storiesHeadlines[
                                                                    index]
                                                                .content;
                                                        var publishedAt =
                                                            storiesHeadlines[
                                                                    index]
                                                                .publishedAt;
                                                        var title =
                                                            storiesHeadlines[
                                                                    index]
                                                                .title;
                                                        var description =
                                                            storiesHeadlines[
                                                                    index]
                                                                .description;

                                                        final image =
                                                            storiesHeadlines[
                                                                    index]
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
                                                  storiesHeadlines[index]
                                                          .title ??
                                                      '',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                subtitle: Text(
                                                    storiesHeadlines[index]
                                                            .author ??
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 5, right: 5),
                                            child: Text(
                                              storiesHeadlines[index].title ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Container(
                                                child: Text(
                                              storiesHeadlines[index]
                                                      .publishedAt ??
                                                  '',
                                              style: TextStyle(fontSize: 15),
                                            )),
                                          ),
                                          Container(
                                            height: 250,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: storiesHeadlines[
                                                                    index]
                                                                .urlToImage ==
                                                            null
                                                        ? NetworkImage(
                                                            "https://www.northampton.ac.uk/wp-content/uploads/2018/11/default-svp_news.jpg",
                                                          )
                                                        : NetworkImage(
                                                            storiesHeadlines[
                                                                    index]
                                                                .urlToImage))),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: ListTile(
                                              title: Text(
                                                storiesHeadlines[index]
                                                        .topStoriesSource
                                                        .name ??
                                                    '',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.red),
                                              ),
                                              subtitle: Text(
                                                storiesHeadlines[index]
                                                        .author ??
                                                    '',
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Text(
                                              storiesHeadlines[index]
                                                      .description ??
                                                  '',
                                              style: TextStyle(fontSize: 18),
                                            )),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Text(
                                              storiesHeadlines[index].content ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
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
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            }),
      ),
    );
  }
}
