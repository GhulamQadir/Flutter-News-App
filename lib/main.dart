import 'package:flutter/material.dart';
import 'package:flutternewsapp/screens/headlines.dart';
import 'package:flutternewsapp/screens/home.dart';
import 'package:flutternewsapp/screens/popular-news.dart';
import 'package:flutternewsapp/screens/sports-news.dart';
import 'package:flutternewsapp/screens/top-stories.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        "/home": (context) => Home(),
        "/top-stories": (context) => TopStories(),
        "/headlines": (context) => Headlines(),
        "/popular-news": (context) => PopularNews(),
        "/sports-news": (context) => SportsNews(),
      },
    );
  }
}
