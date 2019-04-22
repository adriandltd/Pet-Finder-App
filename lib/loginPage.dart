import 'package:animation_exp/SwipeAnimation/index.dart';
import 'package:animation_exp/signupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

class MyLoginPage extends StatelessWidget {
  bool isUserSignedIn = false;

  var userCtrl = TextEditingController();
  var passCtrl = TextEditingController();

  void pushtoHomePage(context) async {
    if (isUserSignedIn == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CardDemo()));
    }
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
          email: userCtrl.text, password: passCtrl.text);
    } catch (e) {
      print(e.toString());
    } finally {
      if (user != null) {
        isUserSignedIn = true;
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
  Future<FirebaseUser> _handleGoogleAccountSignIn(context) async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user =
        await _auth.signInWithCredential(credential).whenComplete(() {
      isUserSignedIn = true;
      pushtoHomePage(context);
    });
    print("signed in " + user.email);
    return user;
  }

  //Facebook Sign in and FireBase Authentication
  Future<FirebaseUser> _handleFacebookAccountSignIn() async {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin.logInWithReadPermissions(['email']);
    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: '2072195696236109',
    );
    debugPrint(result.status.toString());

    if (result.status == FacebookLoginStatus.loggedIn) {
      FirebaseUser user = await _auth.signInWithCredential(credential);
      isUserSignedIn = true;
      return user;
    }
    return null;
  }

//Twitter Sign in and FireBase Authentication

  Future<FirebaseUser> _handleTwitterAccountSignIn() async {
    var twitterLogin = new TwitterLogin(
      consumerKey: 'eUxcPPGGLL59xb7Tx9IBotjjU',
      consumerSecret: 'hhHWA0D0jDxMJKknHovz39LWDiC1vu3MeruSwdWZVUR3fGvDVW',
    );

    final TwitterLoginResult result = await twitterLogin.authorize();
    final AuthCredential credential = TwitterAuthProvider.getCredential(
        authToken: 'eUxcPPGGLL59xb7Tx9IBotjjU',
        authTokenSecret: 'hhHWA0D0jDxMJKknHovz39LWDiC1vu3MeruSwdWZVUR3fGvDVW');

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        var session = result.session;
        FirebaseUser user = await _auth.signInWithCredential(credential);
        isUserSignedIn = true;
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1,0.2,0.4,0.6,0.8,0.9],
          colors: [
            Colors.purple[300],
            Colors.purple[400],
            Colors.purple[700],
            Colors.orange[700],
            Colors.orange[400],
            Colors.orange[300],
          ],
        ),
      ),
      child: Scaffold(
      backgroundColor: Color(0x00000000),
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
                      style: TextStyle(color: Colors.white,
                          fontSize: 35, fontWeight: FontWeight.w600))),
              Padding(padding: const EdgeInsets.only(top: 20.0)),
              Container(
                  width: 325,
                  child: TextField(
                    controller: userCtrl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Email",
                        contentPadding: EdgeInsets.fromLTRB(25,15,15,15),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(40))),
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                  )),
              Padding(padding: const EdgeInsets.only(top: 15.0)),
              Container(
                  width: 325,
                  child: TextField(
                      controller: passCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Password",
                          contentPadding: EdgeInsets.fromLTRB(25,15,15,15),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(40))))),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              ButtonTheme(
                  minWidth: 275.0,
                  height: 45.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    color: Colors.orangeAccent[700],
                    child: Text("Log In",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    onPressed: () {
                      signInWithEmail(context);
                    },
                  )),
              Padding(padding: const EdgeInsets.only(top:10.0)),
              ButtonTheme(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  minWidth: 275.0,
                  height: 45.0,
                  child: RaisedButton(
                      color: Colors.deepPurpleAccent[700],
                      child: Text("Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MySignUpPage()));
                      })),
              Padding(padding: const EdgeInsets.only(top: 30.0)),
              Container(
                width: 305,
                child: GoogleSignInButton(
                  onPressed: () {
                    _handleGoogleAccountSignIn(context)
                        .then((FirebaseUser user) => print(user))
                        .catchError((e) => print(e));
                  },
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 6.0)),
              Container(
                width: 305,
                child: Container(
                  child: FacebookSignInButton(
                    onPressed: () {
                      _handleFacebookAccountSignIn();
                      pushtoHomePage(context);
                    },
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 6.0)),
              Container(
                width: 305,
                child: TwitterSignInButton(
                  onPressed: () {
                    _handleTwitterAccountSignIn()
                        .then((FirebaseUser user) => print(user))
                        .catchError((e) => print(e));
                    pushtoHomePage(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
