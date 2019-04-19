import 'package:animation_exp/SwipeAnimation/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'dart:async';

class MyLoginPage extends StatelessWidget {
  bool isUserSignedIn = false;

  var userCtrl = TextEditingController();
  var passCtrl = TextEditingController();


  void pushtoHomePage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CardDemo()));
  }

  //Email Sign Up and FireBase Authentication
  void signUpWithEmail(context) async {
    // marked async
    FirebaseUser user;
    try {
      user = await _auth.createUserWithEmailAndPassword(
        email: userCtrl.text,
        password: passCtrl.text,
      );
    } catch (e) {
      print(e.toString());
    } finally {
      if (user != null) {
        pushtoHomePage(context);
      } else {
        // sign in unsuccessful
        // ex: prompt the user to try again
      }
    }
  }

  //Email Sign In and FireBase Authentication
  void signInWithEmail(context) async {
    // marked async
    FirebaseUser user;
    try {
      user = await _auth.signInWithEmailAndPassword(
          email: userCtrl.text, 
          password: passCtrl.text
          );
    } catch (e) {
      print(e.toString());
    } finally {
      if (user != null) {
       pushtoHomePage(context);
      } else {
        // sign in unsuccessful
        // ex: prompt the user to try again
      }
    }
  }

  //Google Sign in and FireBase Authentication
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<FirebaseUser> _handleGoogleAccountSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.email);
    return user;
  }

  //Facebook Sign in and FireBase Authentication

  
  //Twitter Sign in and FireBase Authentication


 Future<FirebaseUser> _handleTwitterAccountSignIn() async {
    var twitterLogin = new TwitterLogin(
    consumerKey: 'eUxcPPGGLL59xb7Tx9IBotjjU',
    consumerSecret: 'hhHWA0D0jDxMJKknHovz39LWDiC1vu3MeruSwdWZVUR3fGvDVW',
  );

    final TwitterLoginResult result = await twitterLogin.authorize();
    final AuthCredential credential = TwitterAuthProvider.getCredential(
      authToken: 'eUxcPPGGLL59xb7Tx9IBotjjU', authTokenSecret:'hhHWA0D0jDxMJKknHovz39LWDiC1vu3MeruSwdWZVUR3fGvDVW'
    );

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        var session = result.session;
        FirebaseUser user = await _auth.signInWithCredential(credential);
        return user;
        break;
      case TwitterLoginStatus.cancelledByUser:
        debugPrint(result.status.toString());
        return null;
        break;
      case TwitterLoginStatus.error:
        debugPrint(result.errorMessage.toString());
        return null;
        break;
    }
    return null;
}

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 105.0)),
              SizedBox(
                  height: 75.0,
                  child: Text("Finding BullsEye",
                      style: TextStyle(
                          fontSize: 35, fontWeight: FontWeight.w600))),
              Padding(padding: const EdgeInsets.only(top: 20.0)),
              Container(
                  width: 325,
                  child: TextField(
                    controller: userCtrl,
                    decoration: InputDecoration(
                        hintText: "Email",
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder()),
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                  )),
              Padding(padding: const EdgeInsets.only(top: 15.0)),
              Container(
                  width: 325,
                  child: TextField(
                      keyboardType: TextInputType.number,
                      controller: passCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder()))),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              ButtonTheme(
                  minWidth: 325.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.blueGrey,
                    child: Text("Log In With Email",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    onPressed: () {
                      signInWithEmail(context);
                    },
                  )),
              Padding(padding: const EdgeInsets.only(top: 5.0)),
                ButtonTheme(
                  minWidth: 325.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.blueGrey,
                    child: Text("Sign Up With Email",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    onPressed: () {
                      signUpWithEmail(context);
                    },
                  )),
              Padding(padding: const EdgeInsets.only(top: 20.0)),
              Container(
                width: 325,
                child: GoogleSignInButton(
                  onPressed: () {
                    _handleGoogleAccountSignIn().then((FirebaseUser user) => print(user)).catchError((e) => print(e));
                    pushtoHomePage(context);
                  },
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 6.0)),
              Container(
                width: 325,
                child: FacebookSignInButton(
                  onPressed: () {},
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 6.0)),
              Container(
                width: 325,
                child: TwitterSignInButton(
                  onPressed: () {
                   _handleTwitterAccountSignIn().then((FirebaseUser user) => print(user)).catchError((e) => print(e));
                  pushtoHomePage(context);
                  }),
              ),
            ],
          ),
        ],
      ),
    );
    return scaffold;
  }
}
