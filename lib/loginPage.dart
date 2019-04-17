import 'package:animation_exp/SwipeAnimation/index.dart';
import 'package:flutter/material.dart';


class MyLoginPage extends StatelessWidget {
  var userCtrl = TextEditingController();
  var passCtrl = TextEditingController();

  void loginStuff(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CardDemo()));
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
              Padding(padding: const EdgeInsets.only(top: 205.0)),
              SizedBox(
                  height: 75.0,
                  child: Text("Finding BullsEye")),
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
              Padding(padding: const EdgeInsets.only(top: 18.0)),
              ButtonTheme(
                  minWidth: 325.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.blueGrey,
                    child:
                        Text("Log In", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      loginStuff(context);
                    },
                  ))
            ],
          ),
        ],
      ),
    );
    return scaffold;
  }
}
