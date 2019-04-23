import 'package:findmax/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main(){
  timeDilation = 1.5;
  runApp(new MyApp());
  }

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new MaterialApp(
      title: 'Flutter Demo',
      // showPerformanceOverlay: true,
      theme: new ThemeData(primarySwatch: Colors.blue, fontFamily: 'Myriad'),
      home: new MyLoginPage(),
    );
  }
}
