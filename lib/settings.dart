import 'package:findmax/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage();
  @override
  _SettingsPage createState() {
    return new _SettingsPage();
  }
}

class _SettingsPage extends State<SettingsPage> {
  void checkCredentials() async {
    user = await FirebaseAuth.instance.currentUser();
    setState(() {
      profileurl = user.photoUrl;
      displayName = user.displayName;
    });
  }

  checkforprofilepic() {
    print(profileurl);
    if (profileurl != null) {
      return NetworkImage(user.photoUrl);
    } else {
      return AssetImage("assets/findmaxcatchphrase.png");
    }
  }

  signout() async{
    
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut();
    _googleSignIn.signOut();
    
    print("current user: ${_googleSignIn.currentUser}");
    isUserSignedIn=false;
    
    
  }

  String profileurl;
  FirebaseUser user;
  String displayName;

  Widget _buildWidget() {
    checkCredentials();
    return Column(children: <Widget>[
      Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: checkforprofilepic())))
          ])),
          Padding(padding: const EdgeInsets.only(top: 20.0)),
            Container(
              child: ButtonTheme(
                  minWidth: 275.0,
                  height: 35.0,
                  child: RaisedButton(
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    color: Colors.red,
                    child: Text("Sign Out",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
                    onPressed: () {
                      signout();
                      Navigator.pop(context);
                    },
                  )),
            ),
      
    ]);
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
