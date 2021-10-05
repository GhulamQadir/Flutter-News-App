import 'package:flutter/material.dart';

class AuthPagesMove extends StatefulWidget {
  @override
  _AuthPagesMoveState createState() => _AuthPagesMoveState();
}

class _AuthPagesMoveState extends State<AuthPagesMove> {
  goToLoginScreen() {
    Navigator.of(context).pushNamed("/login");
  }

  goToSignUpScreen() {
    Navigator.of(context).pushNamed("/sign-up");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Column(children: [
        SizedBox(
          height: 30,
        ),
        Container(
          height: 350,
          width: 300,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://previews.123rf.com/images/businessvector/businessvector1510/businessvector151000024/45788264-newspaper-icon.jpg"))),
        ),
        Container(
          width: 100,
          child: TextButton(
            onPressed: goToLoginScreen,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            style: TextButton.styleFrom(backgroundColor: Colors.orange[500]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(
              "or",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        Container(
          width: 100,
          child: TextButton(
            onPressed: goToSignUpScreen,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Sign Up",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            style: TextButton.styleFrom(backgroundColor: Colors.orange[500]),
          ),
        ),
      ])),
    );
  }
}
