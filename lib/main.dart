import 'package:flutter/material.dart';
import 'package:flutternewsapp/screens/auth/Login.dart';
import 'package:flutternewsapp/screens/auth/SignUp.dart';
import 'package:flutternewsapp/screens/auth/authPages.dart';
import 'package:flutternewsapp/screens/favorites.dart';
import 'package:flutternewsapp/screens/headlines.dart';
import 'package:flutternewsapp/screens/home.dart';
import 'package:flutternewsapp/screens/popular-news.dart';
import 'package:flutternewsapp/screens/sports-news.dart';
import 'package:flutternewsapp/screens/top-stories.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutternewsapp/screens/user-profile.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'screens/bottom.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());

  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
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
            home: BottomNavigation(),
            routes: {
              "/home": (context) => Home(),
              "/top-stories": (context) => TopStories(),
              "/headlines": (context) => Headlines(),
              "/popular-news": (context) => PopularNews(),
              "/sports-news": (context) => SportsNews(),
              "/sign-up": (context) => SignUp(),
              "/login": (context) => LoginScreen(),
              "/favorites": (context) => MyFavorites(),
              "/profile-screen": (context) => UserProfile(),
              "/auth-page": (context) => AuthPagesMove(),
              "/bottom": (context) => BottomNavigation()
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
