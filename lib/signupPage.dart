import 'package:findmax/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  void pushtoLoginPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyLoginPage()));
  }

  //Email Sign Up and FireBase Authentication
  void signUpWithEmail(context) async {
    // marked async
    FirebaseUser user;
    FirebaseAuth _auth = FirebaseAuth.instance;
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
        print(e.toString());
      } finally {
        pushtoLoginPage(context);
      }
    } else if (passCtrl.text.length < 6 || passCtrl2.text.length < 6) {
      print("password too short");
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: EdgeInsets.only(top: 35),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: EdgeInsets.only(top: 25.0, left: 15),
            title: const Text(
              'Password must be at least 6 characters long.',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                color: Colors.deepPurpleAccent[700],
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
            titlePadding: EdgeInsets.only(top: 35),
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
                color: Colors.deepPurpleAccent[700],
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

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 0.80,
            center: Alignment.center,
            stops: [.33,.66,.99],
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
          backgroundColor: Color(0x00000000),
          resizeToAvoidBottomPadding: false,
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(top: 10.0)),
                  SizedBox(height: 150,child: Image.asset('assets/findmaxcatchphrase.png', scale:1)),
                  SizedBox(
                      height: 75.0,
                      child: Text("Create an Account",
                          style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w600,fontFamily: 'Myriad'))),
                  Container(
                      width: 325,
                      child: TextFormField(
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
                        autofocus: true,
                        onFieldSubmitted: (userCtrl) {
                          FocusScope.of(context)
                              .requestFocus(textSecondFocusNode);
                        },
                      )),
                  Padding(padding: const EdgeInsets.only(top: 20.0)),
                  Container(
                      width: 325,
                      child: TextFormField(
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
                          FocusScope.of(context)
                              .requestFocus(textThirdFocusNode);
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
                          FocusScope.of(context)
                              .requestFocus(textFourthFocusNode);
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
                  Padding(padding: const EdgeInsets.only(top: 50.0)),
                  ButtonTheme(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      minWidth: 275.0,
                      height: 45.0,
                      child: RaisedButton(
                          color: Color.fromRGBO(255, 128, 43, 1),
                          child: Text("Sign Up",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          onPressed: () {
                            signUpWithEmail(context);
                          })),
                ],
              ),
            ],
          ),
        ));
  }
}
