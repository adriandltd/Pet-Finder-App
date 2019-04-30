import 'package:findmax/SwipeAnimation/index.dart';
import 'package:findmax/forgotpassword.dart';
import 'package:findmax/signupPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyLoginPage extends StatefulWidget {
  MyLoginPage();
  @override
  _MyLoginPage createState() {
    return new _MyLoginPage();
  }
}
bool isUserSignedIn = false;
bool emailVerified = false;
class _MyLoginPage extends State<MyLoginPage> {
  
  bool _loading = false;

  var userCtrl = TextEditingController();
  var passCtrl = TextEditingController();

  void pushtoHomePage(context) async {
    checkCredentials();
    if (isUserSignedIn == true) {
      Navigator.of(context, rootNavigator: true).push(
        CupertinoPageRoute<bool>(
          builder: (BuildContext context) => HomeScreen(),
        ),
      );
    }
  }

  void checkCredentials()async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if(user.displayName == null){
      print("Please update display name.");
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
      if (user != null && user.isEmailVerified) {
        isUserSignedIn = true;
        new Future.delayed(new Duration(seconds: 4), () {
          setState(() {
            _loading = true;
          });
        });
        pushtoHomePage(context);
      } 
      else if (!user.isEmailVerified){
        // sign in unsuccessful
        // ex: prompt the user to try again
        user.sendEmailVerification();
        setState(() {
          _loading = false;
        });
        showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: EdgeInsets.only(top: 35, left: 10, right: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                title: const Text(
                  'Please verify your email.',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    color: Colors.orangeAccent[700],
                    child: Text('Ok', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
      else {
        // sign in unsuccessful
        // ex: prompt the user to try again
        setState(() {
          _loading = false;
        });
        showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: EdgeInsets.only(top: 35, left: 10, right: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                title: const Text(
                  'Incorrect Credentials.',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    color: Colors.orangeAccent[700],
                    child: Text('Ok', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
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
    var result = await facebookLogin.logInWithReadPermissions(['email', 'public_profile']);
    FacebookAccessToken myToken = result.accessToken;

    AuthCredential credential= FacebookAuthProvider.getCredential(accessToken: myToken.token);
    debugPrint(result.status.toString());

    if (result.status == FacebookLoginStatus.loggedIn) {
      FirebaseUser firebaseUser = await FirebaseAuth.instance.signInWithCredential(credential);
      pushtoHomePage(context);
      return firebaseUser;
    }
    return null;
  }

//Twitter Sign in and FireBase Authentication

  Future<FirebaseUser> _handleTwitterAccountSignIn() async {
    final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: 'eUxcPPGGLL59xb7Tx9IBotjjU',
      consumerSecret: 'hhHWA0D0jDxMJKknHovz39LWDiC1vu3MeruSwdWZVUR3fGvDVW',
    );

    TwitterLoginResult result = await twitterLogin.authorize();
    TwitterSession currentSession = result.session;
    TwitterLoginStatus status = result.status;
    final AuthCredential credential = TwitterAuthProvider.getCredential(
        authToken: currentSession.token, authTokenSecret: currentSession.secret);
    
    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        FirebaseUser user = await FirebaseAuth.instance.signInWithCredential(credential);
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

  Widget _buildWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
             Padding(padding: const EdgeInsets.only(top: 85.0)),
            SizedBox(
                height: 130,
                child: Image.asset('assets/findmaxcatchphrase.png', scale: 1)),
                 Padding(padding: const EdgeInsets.only(top: 35.0)),
            Container(
                width: 325,
                child: TextField(
                  controller: userCtrl,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Email",
                      hintStyle: TextStyle(
                        fontFamily: 'Myriad',
                      ),
                      contentPadding: EdgeInsets.fromLTRB(25, 15, 15, 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40))),
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                )),
            Padding(padding: const EdgeInsets.only(top: 10.0)),
            Container(
                width: 325,
                child: TextField(
                    controller: passCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Password",
                        contentPadding: EdgeInsets.fromLTRB(25, 15, 15, 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40))))),
            Padding(padding: const EdgeInsets.only(top: 10.0)),
            ButtonTheme(
                minWidth: 275.0,
                height: 45.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  color: Color.fromRGBO(255, 194, 30, 1),
                  child: Text("Log In",
                      style: TextStyle(
                          color: Colors.blueGrey[900],
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                  onPressed: () {
                    setState(() {
                      _loading = true;
                    });
                    signInWithEmail(context);
                  },
                )),
            Padding(padding: const EdgeInsets.only(top: 1.0)),
            Row(
              children: <Widget>[
                ButtonTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    minWidth: 100.0,
                    height: 25.0,
                    child: RaisedButton(
                        color: Colors.blueGrey[700],
                        child: Text("Forgot Password?",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => ForgotPasswordPage(),
                            ),
                          );
                        })),
                        Padding(padding: const EdgeInsets.only(left: 20.0)),
                ButtonTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    minWidth: 100.0,
                    height: 25.0,
                    child: RaisedButton(
                        color: Colors.blueGrey[700],
                        child: Text("Create an account?",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => MySignUpPage(),
                            ),
                          );
                        })),
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 30.0)),
            Container(
              width: 280,
              child: GoogleSignInButton(
                onPressed: () {
                  _handleGoogleAccountSignIn(context)
                      .then((FirebaseUser user) => print(user))
                      .catchError((e) => print(e));
                },
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 3.0)),
            Container(
              width: 280,
              child: Container(
                child: FacebookSignInButton(
                  onPressed: () {
                    _handleFacebookAccountSignIn();
                    pushtoHomePage(context);
                  },
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 3.0)),
            Container(
              width: 280,
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
    );
  }

  @override
  Widget build(BuildContext context) {
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
              Color.fromRGBO(255, 180, 109, 1), //Oranges
              Color.fromRGBO(255, 150, 70, 1),
              Color.fromRGBO(255, 128, 43, 1),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Color(0x00000000),
          resizeToAvoidBottomPadding: false,
          body: ModalProgressHUD(
            child: _buildWidget(),
            inAsyncCall: _loading,
            color: Colors.orangeAccent,
            dismissible: true,
            progressIndicator: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent)),
          ),
        ));
  }
}
