import 'package:flutter/material.dart';
import 'package:flutternewsapp/models/everything-model.dart';
import 'package:flutternewsapp/screens/headlines.dart';
import 'package:flutternewsapp/screens/popular-news.dart';
import 'package:flutternewsapp/screens/sports-news.dart';
import 'package:flutternewsapp/screens/top-stories.dart';

import 'home.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentTab = 0;

  Widget currentScreen = Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageStorage(bucket: PageStorageBucket(), child: currentScreen),
      bottomNavigationBar: BottomAppBar(
        // notchMargin: 50,
        color: Colors.red[500],
        child: Container(
          height: 68,
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
                  Widget>[
                Column(
                  children: [
                    MaterialButton(
                        minWidth: 50,
                        onPressed: () {
                          setState(() {
                            currentScreen = Home();
                            currentTab = 0;
                          });
                        },
                        child: Icon(Icons.home,
                            size: 25,
                            color:
                                currentTab == 0 ? Colors.white : Colors.black)),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentScreen = Home();
                          currentTab = 0;
                        });
                      },
                      child: Text("Home",
                          style: TextStyle(
                              color: currentTab == 0
                                  ? Colors.white
                                  : Colors.black)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    MaterialButton(
                        minWidth: 60,
                        onPressed: () {
                          setState(() {
                            currentScreen = PopularNews();
                            currentTab = 1;
                          });
                        },
                        child: Icon(Icons.align_vertical_top_rounded,
                            size: 25,
                            color:
                                currentTab == 1 ? Colors.white : Colors.black)),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentScreen = PopularNews();
                          currentTab = 1;
                        });
                      },
                      child: Text("Popular",
                          style: TextStyle(
                              color: currentTab == 1
                                  ? Colors.white
                                  : Colors.black)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    MaterialButton(
                        minWidth: 60,
                        onPressed: () {
                          setState(() {
                            currentScreen = SportsNews();
                            currentTab = 2;
                          });
                        },
                        child: Icon(Icons.run_circle,
                            size: 25,
                            color:
                                currentTab == 2 ? Colors.white : Colors.black)),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentScreen = SportsNews();
                          currentTab = 2;
                        });
                      },
                      child: Text("Sports",
                          style: TextStyle(
                              color: currentTab == 2
                                  ? Colors.white
                                  : Colors.black)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    MaterialButton(
                        minWidth: 60,
                        onPressed: () {
                          setState(() {
                            currentScreen = TopStories();
                            currentTab = 3;
                          });
                        },
                        child: Icon(Icons.amp_stories,
                            size: 25,
                            color:
                                currentTab == 3 ? Colors.white : Colors.black)),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentScreen = TopStories();
                          currentTab = 3;
                        });
                      },
                      child: Text("Stories",
                          style: TextStyle(
                              color: currentTab == 3
                                  ? Colors.white
                                  : Colors.black)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    MaterialButton(
                        minWidth: 60,
                        onPressed: () {
                          setState(() {
                            currentScreen = Headlines();
                            currentTab = 4;
                          });
                        },
                        child: Icon(Icons.new_label,
                            size: 25,
                            color:
                                currentTab == 4 ? Colors.white : Colors.black)),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentScreen = Headlines();
                          currentTab = 4;
                        });
                      },
                      child: Text("Headlines",
                          style: TextStyle(
                              color: currentTab == 4
                                  ? Colors.white
                                  : Colors.black)),
                    ),
                  ],
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
