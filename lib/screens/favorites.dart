import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyFavorites extends StatefulWidget {
  @override
  _MyFavoritesState createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  String title;
  String description;
  String author;
  final firebaseUser = FirebaseAuth.instance.currentUser;

  Stream postStream;

  void initState() {
    postStream = FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .collection("posts")
        .snapshots();

    super.initState();
  }

  goToHome() {
    Navigator.of(context).pushNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null
          ? Container(
              child: Center(
                  child: Text("Kindly Logged in or signUp with your account")),
            )
          : Scaffold(
              appBar: AppBar(
                title: Center(child: Text("My Favorites")),
                backgroundColor: Colors.red,
                leading: GestureDetector(
                    onTap: goToHome, child: Icon(Icons.arrow_back)),
              ),
              body: Center(
                child: Container(
                    child: StreamBuilder<QuerySnapshot<Object>>(
                  stream: postStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading...");
                    }
                    if (snapshot.data == null) {
                      return CircularProgressIndicator();
                    }

                    return ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        Map data = document.data();
                        String id = document.id;
                        data["id"] = id;

                        return SingleChildScrollView(
                          child: Column(
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
                                                          image: data["image"] ==
                                                                  null
                                                              ? NetworkImage(
                                                                  "https://www.northampton.ac.uk/wp-content/uploads/2018/11/default-svp_news.jpg")
                                                              : NetworkImage(data[
                                                                  "image"]))),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: ListTile(
                                                      title: Text(
                                                        data["name"] ?? '',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  title: Text(
                                                    data["title"] ?? '',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  subtitle: Text(
                                                      data["author"] ?? ''),
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
                                                data["title"] ?? '',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Container(
                                                  child: Text(
                                                data["publishedAt"] ?? '',
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
                                                      image: data["image"] ==
                                                              null
                                                          ? NetworkImage(
                                                              "https://www.northampton.ac.uk/wp-content/uploads/2018/11/default-svp_news.jpg",
                                                            )
                                                          : NetworkImage(
                                                              data["image"]))),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: ListTile(
                                                title: Text(
                                                  data["name"] ?? '',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.red),
                                                ),
                                                subtitle: Text(
                                                  data["author"] ?? '',
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
                                                data["description"] ?? '',
                                                style: TextStyle(fontSize: 18),
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
                                                data["content"] ?? '',
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
                        );
                      }).toList(),
                    );
                  },
                )),
              ),
            ),
    );
  }
}
