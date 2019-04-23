import 'package:findmax/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class MySignUpPage extends StatefulWidget {
  MySignUpPage();
  @override
  _MySignUpPage createState() {
    return new _MySignUpPage();
  }
}

class _MySignUpPage extends State<MySignUpPage> {
  var userCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  var userCtrl2 = TextEditingController();
  var passCtrl2 = TextEditingController();

  bool _loading = false;

  void pushtoLoginPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyLoginPage()));
  }

  //Email Sign Up and FireBase Authentication
  void signUpWithEmail(context) async {
    // marked async
    FirebaseUser user;
    FirebaseAuth _auth = FirebaseAuth.instance;
    bool accountexists = false;
    if (passCtrl.text == passCtrl2.text &&
        userCtrl.text == userCtrl2.text &&
        passCtrl.text.length > 5 &&
        passCtrl2.text.length > 5) {
      try {
        user = await _auth.createUserWithEmailAndPassword(
          email: userCtrl.text,
          password: passCtrl.text,
        );
      } catch (e) {
        if (e.toString().contains("ERROR_EMAIL_ALREADY_IN_USE")) {
          accountexists = true;
        }
        print(e.toString());
      } finally {
        if (accountexists == false) {
          setState(() {
            _loading = true;
          });
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  titlePadding: EdgeInsets.only(top: 35, left: 10, right: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  title: const Text(
                    'Sucessfully Registered!',
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      color: Colors.orangeAccent[700],
                      child: Text('Ok', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _loading = false;
                        });
                        pushtoLoginPage(context);
                      },
                    ),
                  ],
                );
              });
        } else {
          setState(() {
            _loading = true;
          });
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  titlePadding: EdgeInsets.only(top: 35, left: 10, right: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  title: const Text(
                    'Email already taken.',
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      color: Colors.orangeAccent[700],
                      child: Text('Ok', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _loading = false;
                        });
                      },
                    ),
                  ],
                );
              });
        }
      }
    } else if (passCtrl.text.length < 6 || passCtrl2.text.length < 6) {
      print("password too short");
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: EdgeInsets.only(top: 35, left: 10, right: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: const Text(
              'Password must be at least 6 characters long.',
              style: TextStyle(fontSize: 28),
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
        },
      );
    } else {
      print("email/password invalid");
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: EdgeInsets.only(top: 35, left: 10, right: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: const Text(
              'Email/Password Does Not Match.',
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
        },
      );
    }
  }

  FocusNode textSecondFocusNode = FocusNode();
  FocusNode textThirdFocusNode = FocusNode();
  FocusNode textFourthFocusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();

  Widget _buildWidget() {
    return  KeyboardAvoider(
      autoScroll: true,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                  height: 130,
                  child:
                      Image.asset('assets/findmaxcatchphrase.png', scale: 1)),
              Padding(padding: const EdgeInsets.only(bottom: 60.0)),
              Container(
                  width: 325,
                  child: TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: userCtrl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Email",
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40))),
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    onFieldSubmitted: (userCtrl) {
                      FocusScope.of(context).requestFocus(textSecondFocusNode);
                    },
                  )),
              Padding(padding: const EdgeInsets.only(top: 20.0)),
              Container(
                  width: 325,
                  child: TextFormField(
                    autofocus: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: userCtrl2,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Confirm Email",
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40))),
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    onFieldSubmitted: (userCtrl2) {
                      FocusScope.of(context).requestFocus(textThirdFocusNode);
                    },
                    focusNode: textSecondFocusNode,
                  )),
              Padding(padding: const EdgeInsets.only(top: 20.0)),
              Container(
                  width: 325,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: passCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Password",
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40))),
                    onFieldSubmitted: (passCtrl) {
                      FocusScope.of(context).requestFocus(textFourthFocusNode);
                    },
                    focusNode: textThirdFocusNode,
                  )),
              Padding(padding: const EdgeInsets.only(top: 20.0)),
              Container(
                  width: 325,
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: passCtrl2,
                    obscureText: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Confirm Password",
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40))),
                    focusNode: textFourthFocusNode,
                  )),
              Padding(padding: const EdgeInsets.only(top: 40.0)),
              ButtonTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  minWidth: 275.0,
                  height: 45.0,
                  child: RaisedButton(
                      color: Color.fromRGBO(255, 128, 43, 1),
                      child: Text("Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      onPressed: () {
                        signUpWithEmail(context);
                      })),
            ],
          ),
        ],
      ),
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
          appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed:(){Navigator.pop(context);}), elevation: 3, centerTitle: true,backgroundColor: Color.fromRGBO(255, 128, 43, 1), title:Text("Account Creation",
                      style: TextStyle(
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0.25, 0.25),
                              blurRadius: 12.0,
                              color: Color.fromARGB(185, 0, 0, 0),
                            ),
                          ],
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Myriad'))),
          backgroundColor: Color(0x00000000),
          resizeToAvoidBottomPadding: false,
          body: ModalProgressHUD(
            child: _buildWidget(),
            inAsyncCall: _loading,
            color: Colors.orangeAccent,
            dismissible: true,
            progressIndicator: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent)),
          ),
        ));
  }
}
