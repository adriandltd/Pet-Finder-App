import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class UserPostPage extends StatefulWidget {
  UserPostPage();
  @override
  _UserPostPage createState() {
    return new _UserPostPage();
  }
}

class _UserPostPage extends State<UserPostPage> {
  
  Widget _buildWidget() {
    return Container(

    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 0.9,
            center: Alignment.center,
            stops: [.33, .66, .99],
            colors: [
              // Color.fromRGBO(255, 180, 109, 1),
              // Color.fromRGBO(255, 150, 70, 1),
              // Color.fromRGBO(255, 128, 43, 1),
              Color.fromRGBO(255, 212, 109, 1),
              Color.fromRGBO(255, 200, 70, 1),
              Color.fromRGBO(255, 194, 43, 1),
            ],
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              elevation: 3,
              centerTitle: true,
              backgroundColor: Color.fromRGBO(255, 128, 43, 1),
              title: Text("Make a Post",
                  style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0.25, 0.25),
                          blurRadius: 12.0,
                          color: Color.fromARGB(185, 0, 0, 0),
                        ),
                      ],
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Myriad'))),
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: false,
          body: _buildWidget(),
        ));
  }
}
