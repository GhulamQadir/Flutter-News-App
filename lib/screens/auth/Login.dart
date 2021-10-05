import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  final GoogleSignIn googleSignIn = new GoogleSignIn();
  Future<UserCredential> loginWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      var signCre =
          await FirebaseAuth.instance.signInWithCredential(credential);
      await db.collection("users").doc(signCre.user.uid).set({
        "userName": googleUser.displayName,
        "email": googleUser.email,
        "image": googleUser.photoUrl
      });

      // return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
  }

  goToSignUpScreen() {
    Navigator.of(context).pushNamed("/sign-up");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 5),
                  child: Icon(Icons.arrow_back),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://previews.123rf.com/images/businessvector/businessvector1510/businessvector151000024/45788264-newspaper-icon.jpg"))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.orange[300],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xffF8F0E3),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.orange[300],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xffF8F0E3),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                      width: 150,
                      child: TextButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "Login",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orange[500]),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              )))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 13, bottom: 10),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? "),
                        GestureDetector(
                            onTap: goToSignUpScreen,
                            child: Text(
                              "Create one",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.orange[400]),
                            )),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                      width: 180,
                      child: TextButton(
                          onPressed: loginWithGoogle,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "Login with Google",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orange[500]),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              )))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
