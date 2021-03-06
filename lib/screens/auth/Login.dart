import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutternewsapp/screens/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home()), (route) => false);
    } catch (e) {
      print(e.toString());
    }
  }

  loginWithEmailPassword() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    FirebaseAuth auth = FirebaseAuth.instance;

    final String email = emailController.text;
    final String password = passwordController.text;
    final UserCredential user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }

  goToSignUpScreen() {
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: goToHome,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.red,
                    ),
                  ),
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
                                "https://mapolypress.files.wordpress.com/2018/04/news1.png"))),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 20, right: 20),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isNotEmpty && value.length > 7) {
                              return null;
                            } else if (value.length < 7 && value.isNotEmpty) {
                              return "Your email address is too short";
                            } else {
                              return "Please enter your email address";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.red[500],
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
                        padding:
                            const EdgeInsets.only(top: 15, left: 20, right: 20),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter your password";
                            } else if (value.length < 6) {
                              return "Your password is too short";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.red[500],
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
                                onPressed: loginWithEmailPassword,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red[400]),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
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
                                        fontSize: 16, color: Colors.red[500]),
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
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red[400]),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                    )))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
