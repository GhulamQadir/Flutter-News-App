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
              ),
              body: Center(
                child: Container(
                    child: StreamBuilder<QuerySnapshot<Object>>(
                  stream: postStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    print("Start of builder method");
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
                              Image.network(data["image"]),
                              Text(
                                "Title is:   ${data["title"]} ?? ''",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Description is:   ${data["description"]} ?? ''",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 30,
                              ),
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
