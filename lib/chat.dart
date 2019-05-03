import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatPage extends StatefulWidget {
  ChatPage();
  @override
  _ChatPage createState() {
    return new _ChatPage();
  }
}

class _ChatPage extends State<ChatPage> {
  void checkCredentials() async {
    user = await FirebaseAuth.instance.currentUser();
  }

  FirebaseUser user;

  Widget _buildWidget() {
    checkCredentials();
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 0.80,
          center: Alignment.center,
          stops: [.33, .66, .99],
          colors: [
            // Color.fromRGBO(255, 212, 109, 1),
            // Color.fromRGBO(255, 200, 70, 1),
            // Color.fromRGBO(255, 194, 43, 1),
            Color.fromRGBO(255, 212, 109, 1), //Yellow
            Color.fromRGBO(255, 200, 70, 1),
            Color.fromRGBO(255, 194, 43, 1),
          ],
        ),
      ),
      child: ListView(children: <Widget>[
        
      ]),
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
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: false,
          body: _buildWidget(),
        ));
  }
}
