import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutternewsapp/models/everything-model.dart';
import 'package:flutternewsapp/screens/headlines.dart';
import 'package:flutternewsapp/screens/popular-news.dart';
import 'package:flutternewsapp/screens/sports-news.dart';
import 'package:flutternewsapp/screens/top-stories.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:animations/animations.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Everything>> getTopHeadlines() async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=157c9287a12840a49bc2a7d0f9228c01"));
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

  final user = FirebaseAuth.instance.currentUser;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  signOut() async {
    await auth.signOut();
    googleSignIn.disconnect();
    setState(() {});
    print("user diconnected");

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                title: Text(
                  "News Express",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                backgroundColor: Colors.red[500],
                actions: [
                  TextButton(
                    onPressed: FirebaseAuth.instance.currentUser == null
                        ? goToLoginScreen
                        : signOut,
                    child: FirebaseAuth.instance.currentUser == null
                        ? Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )
                        : Text(
                            "SignOut",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                  )
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
                                  child:
                                      FirebaseAuth.instance.currentUser == null
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
                future: getTopHeadlines(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Everything>> snapshot) {
                  if (snapshot.hasData) {
                    List<Everything> everything = snapshot.data;
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: everything.length,
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
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
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
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: everything[
                                                                            index]
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
                                                        const EdgeInsets.only(
                                                            left: 3),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: ListTile(
                                                        title: Text(
                                                          everything[index]
                                                                  .source
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
                                                                everything[
                                                                        index]
                                                                    .source
                                                                    .name;
                                                            var author =
                                                                everything[
                                                                        index]
                                                                    .author;
                                                            var content =
                                                                everything[
                                                                        index]
                                                                    .content;
                                                            var publishedAt =
                                                                everything[
                                                                        index]
                                                                    .publishedAt;
                                                            var title =
                                                                everything[
                                                                        index]
                                                                    .title;
                                                            var description =
                                                                everything[
                                                                        index]
                                                                    .description;

                                                            final image =
                                                                everything[
                                                                        index]
                                                                    .urlToImage;

                                                            FirebaseFirestore
                                                                db =
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
                                                                    "name":
                                                                        name,
                                                                    "title":
                                                                        title,
                                                                    "description":
                                                                        description,
                                                                    "image":
                                                                        image,
                                                                    "author":
                                                                        author,
                                                                    "content":
                                                                        content,
                                                                    "publishedAt":
                                                                        publishedAt,
                                                                  });
                                                            print(
                                                                "added to favorites");
                                                            // EasyLoading.showSuccess(
                                                            //     'Added to favourites');
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                      everything[index].title ??
                                                          '',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    subtitle: Text(
                                                        everything[index]
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
                                                  everything[index].title ?? '',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Container(
                                                    child: Text(
                                                  everything[index]
                                                          .publishedAt ??
                                                      '',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                )),
                                              ),
                                              Container(
                                                height: 250,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: everything[index]
                                                                    .urlToImage ==
                                                                null
                                                            ? NetworkImage(
                                                                "https://www.northampton.ac.uk/wp-content/uploads/2018/11/default-svp_news.jpg",
                                                              )
                                                            : NetworkImage(
                                                                everything[
                                                                        index]
                                                                    .urlToImage))),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: ListTile(
                                                  title: Text(
                                                    everything[index]
                                                            .source
                                                            .name ??
                                                        '',
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
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    child: Text(
                                                  everything[index]
                                                          .description ??
                                                      '',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    child: Text(
                                                  everything[index].content ??
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
                })));
  }
}
