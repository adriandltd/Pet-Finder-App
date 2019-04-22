import 'package:animation_exp/loginPage.dart';
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
    if (passCtrl.text == passCtrl2.text && userCtrl.text == userCtrl2.text && passCtrl.text.length > 5 && passCtrl2.text.length > 5) {
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
    } 
    else if (passCtrl.text.length < 6 || passCtrl2.text.length < 6) {
      print("password too short");
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            contentPadding: EdgeInsets.only(top: 25.0, left: 15),
            content: const Text('Password must be at least 6 characters long'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    else {
      print("email/password invalid");
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            contentPadding: EdgeInsets.only(top: 25.0, left: 15),
            title: const Text('Email/Password Does Not Match'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
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
    var scaffold = Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 120.0)),
              SizedBox(
                  height: 75.0,
                  child: Text("Sign Up With Email",
                      style: TextStyle(
                          fontSize: 35, fontWeight: FontWeight.w600))),
              Container(
                  width: 325,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: userCtrl,
                    decoration: InputDecoration(
                        hintText: "Email",
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder()),
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    autofocus: true,
                    onFieldSubmitted: (userCtrl) {
                      FocusScope.of(context).requestFocus(textSecondFocusNode);
                    },
                  )),
              Padding(padding: const EdgeInsets.only(top: 20.0)),
              Container(
                  width: 325,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: userCtrl2,
                    decoration: InputDecoration(
                        hintText: "Confirm Email",
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder()),
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
                        hintText: "Password",
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder()),
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
                        hintText: "Confirm Password",
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder()),
                    focusNode: textFourthFocusNode,
                  )),
              Padding(padding: const EdgeInsets.only(top: 40.0)),
              ButtonTheme(
                  minWidth: 325.0,
                  height: 50.0,
                  child: RaisedButton(
                      color: Colors.blueGrey,
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
    return scaffold;
  }
}
