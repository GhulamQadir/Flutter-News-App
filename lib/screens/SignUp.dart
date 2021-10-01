import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await db
          .collection("users")
          .doc(googleUser.id)
          .set({"Name": googleUser.displayName, "Email": googleUser.email});

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("SignUp page")),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              child: Text(
                "Hey There,",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              "Welcome Back",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            Text("Login to your account to continue"),
            SizedBox(
              height: 50,
            ),
            Center(
                child: TextButton(
              onPressed: signInWithGoogle,
              child: Text("Sign Up with Google"),
              style: TextButton.styleFrom(backgroundColor: Colors.white),
            )),
            SizedBox(
              height: 50,
            ),
            Center(
                child: TextButton(
              onPressed: () {},
              child: Text("Sign Up with Facebook"),
              style: TextButton.styleFrom(backgroundColor: Colors.white),
            ))
          ],
        ),
      ),
    );
  }
}
