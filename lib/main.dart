import 'package:findmax/SwipeAnimation/index.dart';
import 'package:findmax/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

Future main() async {
  timeDilation = 1.7;
  runApp(new MyApp());
}

checkifUserLoggedIn(){
  if (!isUserSignedIn){
    return new MyLoginPage();
  }
  else{
    return new HomeScreen();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor:
          Color.fromRGBO(255, 128, 43, 1), //or set color with: Color(0xFF0000FF)
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new MaterialApp(
      title: 'Flutter Demo',
      // showPerformanceOverlay: true,
      theme: new ThemeData(primarySwatch: Colors.blue, fontFamily: 'Myriad'),
      home: checkifUserLoggedIn(),
    );
  }
}
