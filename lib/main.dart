import 'package:flutter/material.dart';
import 'package:flutternewsapp/screens/SignUp.dart';
import 'package:flutternewsapp/screens/favorites.dart';
import 'package:flutternewsapp/screens/headlines.dart';
import 'package:flutternewsapp/screens/home.dart';
import 'package:flutternewsapp/screens/popular-news.dart';
import 'package:flutternewsapp/screens/sports-news.dart';
import 'package:flutternewsapp/screens/top-stories.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutternewsapp/screens/user-profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container(
            child:
                Text("Something went wrong!", textDirection: TextDirection.ltr),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Home(),
            routes: {
              "/home": (context) => Home(),
              "/top-stories": (context) => TopStories(),
              "/headlines": (context) => Headlines(),
              "/popular-news": (context) => PopularNews(),
              "/sports-news": (context) => SportsNews(),
              "/sign-up": (context) => SignUp(),
              "/my-favorites": (context) => MyFavorites(),
              "/profile-screen": (context) => UserProfile(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
            child: Text("Loading...", textDirection: TextDirection.ltr));
      },
    );
  }
}
