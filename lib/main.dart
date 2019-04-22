import 'package:findmax/loginPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      // showPerformanceOverlay: true,
      theme: new ThemeData(
        primarySwatch: Colors.blue, fontFamily: 'Myriad'
      ),
      home: new MyLoginPage(),
    );
  }
}
