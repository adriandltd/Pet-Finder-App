import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage();
  @override
  _EditProfilePage createState() {
    return new _EditProfilePage();
  }
}

class _EditProfilePage extends State<EditProfilePage> {
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
      )),
      child: ListView(children: <Widget>[
        Padding(padding: const EdgeInsets.only(top: 45.0)),
        ListTile(
          title: Text(
            "Change Display Name",
            style: TextStyle(fontSize: 25, color: Colors.black54),
          ),
          leading: Icon(
            Icons.person,
            size: 40,
            color: Colors.black87,
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 30.0)),
        ListTile(
          title: Text(
            "Change Email",
            style: TextStyle(fontSize: 25, color: Colors.black54),
          ),
          leading: Icon(
            Icons.email,
            size: 40,
            color: Colors.black87,
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 30.0)),
        ListTile(
          title: Text(
            "Change Password",
            style: TextStyle(fontSize: 25, color: Colors.black54),
          ),
          leading: Icon(
            Icons.vpn_key,
            size: 40,
            color: Colors.black87,
          ),
        ),
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
          appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              elevation: 3,
              centerTitle: true,
              backgroundColor: Color.fromRGBO(255, 128, 43, 1),
              title: Text("Edit Profile",
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
