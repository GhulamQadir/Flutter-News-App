import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String userName;
  String email;
  String image;

  currentUserProfile() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        userName = ds.data()['userName'];
        email = ds.data()['email'];
        image = ds.data()['image'];
      }).catchError((e) {
        print(e);
      });
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  signOut() async {
    await auth.signOut();
    await googleSignIn.disconnect();

    Navigator.of(context).pushNamed("/sign-up");
  }

  goToHome() {
    Navigator.of(context).pushNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Center(child: Text("Account Details")),
              backgroundColor: Colors.red,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: goToHome,
              ),
              actions: [Icon(Icons.logout)],
            ),
            body: FutureBuilder(
                future: currentUserProfile(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return Text("Loading please wait ");

                  return SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Center(
                              child: Container(
                            child: Center(
                              child: CircleAvatar(
                                radius: 100,
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(image ?? ''),
                              ),
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              "$userName",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              "$email",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ])),
                  );
                })));
  }
}
