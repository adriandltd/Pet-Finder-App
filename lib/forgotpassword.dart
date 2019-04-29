import 'package:findmax/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage();
  @override
  _ForgotPasswordPage createState() {
    return new _ForgotPasswordPage();
  }
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  var userCtrl = TextEditingController();

  bool _loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Widget _buildWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.only(bottom: 60.0)),
            SizedBox(
                height: 130,
                child: Image.asset('assets/findmaxcatchphrase.png', scale: 1)),
            Padding(padding: const EdgeInsets.only(top: 40.0)),
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
                  onFieldSubmitted: (userCtrl) {},
                )),
            Padding(padding: const EdgeInsets.only(top: 50.0)),
            ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                minWidth: 275.0,
                height: 45.0,
                child: RaisedButton(
                    color: Color.fromRGBO(255, 128, 43, 1),
                    child: Text("Reset",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    onPressed: () {
                      sendPasswordResetEmail(userCtrl.text);
                      if (userCtrl.text.contains('@') && userCtrl.text.isNotEmpty) {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                titlePadding: EdgeInsets.only(
                                    top: 35, left: 10, right: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                title: const Text(
                                  'Password reset link has been sent to the submitted email.',
                                  style: TextStyle(fontSize: 28),
                                  textAlign: TextAlign.center,
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    color: Colors.orangeAccent[700],
                                    child: Text('Ok',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                      else {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                titlePadding: EdgeInsets.only(
                                    top: 35, left: 10, right: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                title: const Text(
                                  'Please provide a valid email.',
                                  style: TextStyle(fontSize: 28),
                                  textAlign: TextAlign.center,
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    color: Colors.orangeAccent[700],
                                    child: Text('Ok',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                    })),
          ],
        )
      ],
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
          appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed:(){Navigator.pop(context);}), elevation: 3, centerTitle: true,backgroundColor: Color.fromRGBO(255, 128, 43, 1), title:Text("Password Reset",
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
