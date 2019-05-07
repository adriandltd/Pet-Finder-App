import 'dart:async';
import 'package:findmax/chat.dart' as third;
import 'package:findmax/SwipeAnimation/data.dart';
import 'package:findmax/SwipeAnimation/dummyCard.dart';
import 'package:findmax/SwipeAnimation/activeCard.dart';
import 'package:findmax/settings.dart' as first;
import 'package:flutter/cupertino.dart';

//import 'package:animation_exp/PageReveal/page_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import '../UserPosts.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0;
  TabController tabcontroller;

  List data = imageData;
  List selectedData = [];
  void initState() {
    super.initState();
    tabcontroller = TabController(length: 3, vsync: this, initialIndex: 1);
    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    rotate = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = data.removeLast();
          data.insert(0, i);

          _buttonController.reset();
        }
      });
    });

    right = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom = new Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    width = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    tabcontroller.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  dismissImg(DecorationImage img) {
    setState(() {
      data.remove(img);
    });
  }

  addImg(DecorationImage img) {
    setState(() {
      data.remove(img);
      selectedData.add(img);
    });
  }

  swipeRight() {
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    _swipeAnimation();
  }

  swipeLeft() {
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;

    double initialBottom = 15.0;
    var dataLength = data.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -10.0;
    return new WillPopScope(
        onWillPop: () async => false,
        child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 0.80,
                center: Alignment.center,
                stops: [.33, .66, .99],
                colors: [
                  // Color.fromRGBO(255, 212, 109, 1),
                  // Color.fromRGBO(255, 200, 70, 1),
                  // Color.fromRGBO(255, 194, 43, 1),
                  Color.fromRGBO(255, 180, 109, 1), //Oranges
                  Color.fromRGBO(255, 150, 70, 1),
                  Color.fromRGBO(255, 128, 43, 1),
                ],
              ),
            ),
            child: (new Scaffold(
              floatingActionButton: FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: Color.fromRGBO(255, 128, 43, 1),
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute<bool>(
                      builder: (BuildContext context) => UserPostPage(),
                    ),
                  );
                },
              ),
              appBar: new AppBar(
                bottom: TabBar(
                  controller: tabcontroller,
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.chat)),
                    Tab(icon: Icon(Icons.home)),
                    Tab(icon: Icon(Icons.settings)),
                  ],
                ),
                backgroundColor: Color.fromRGBO(255, 128, 43, 1),
                leading: Container(),
                centerTitle: true,
                title: SizedBox(
                    height: 130,
                    child: Image.asset(
                      'assets/findmaxcatchphrase.png',
                      scale: 1,
                      alignment: Alignment.center,
                    )),
              ),
              body: TabBarView(
                controller: tabcontroller,
                children: <Widget>[
                  third.ChatPage(),
                  Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        radius: 0.9,
                        center: Alignment.center,
                        stops: [.33, .66, .99],
                        colors: [
                          // Color.fromRGBO(255, 180, 109, 1),
                          // Color.fromRGBO(255, 150, 70, 1),
                          // Color.fromRGBO(255, 128, 43, 1),
                          Color.fromRGBO(255, 212, 109, 1), //Yellow
                          Color.fromRGBO(255, 200, 70, 1),
                          Color.fromRGBO(255, 194, 43, 1),
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: dataLength > 0
                        ? new Stack(
                            alignment: AlignmentDirectional.center,
                            children: data.map((item) {
                              if (data.indexOf(item) == dataLength - 1) {
                                return cardDemo(
                                    item,
                                    bottom.value,
                                    right.value,
                                    0.0,
                                    backCardWidth + 10,
                                    rotate.value,
                                    rotate.value < -10 ? 0.1 : 0.0,
                                    context,
                                    dismissImg,
                                    flag,
                                    addImg,
                                    swipeRight,
                                    swipeLeft);
                              } else {
                                backCardPosition = backCardPosition - 10;
                                backCardWidth = backCardWidth + 10;

                                return cardDemoDummy(item, backCardPosition,
                                    0.0, 0.0, backCardWidth, 0.0, 0.0, context);
                              }
                            }).toList())
                        : new Text("No Event Left",
                            style: new TextStyle(
                                color: Colors.white, fontSize: 50.0)),
                  ),
                  first.SettingsPage(),
                ],
              ),
            ))));
  }
}
