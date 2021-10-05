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
    // await googleSignIn.disconnect();
    await auth.signOut();

    Navigator.of(context).pushNamed("/sign-up");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Center(child: Text("My Profile")),
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
                                backgroundImage: NetworkImage(image ?? ''),
                              ),
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              "Name: $userName",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              "Email: $email",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: signOut, child: Text("sign out"))
                        ])
                        // body: Column(
                        //   children: [
                        //     Center(
                        //       child: CircleAvatar(
                        //         radius: 100,
                        //         backgroundImage: NetworkImage(user.photoURL ?? ''),
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.only(top: 20),
                        //       child: Text(
                        //         "Name: ${user.displayName}",
                        //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.only(top: 20),
                        //       child: Text(
                        //         "Email: ${user.email}",
                        //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.only(top: 20),
                        //       child: Text(
                        //         "Phone Number: ${user.phoneNumber ?? 'Not provided'} ",
                        //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.only(top: 20),
                        //       child: Text(
                        //         "Email: ${user.emailVerified}",
                        //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        ),
                  );
                })));
  }
}
