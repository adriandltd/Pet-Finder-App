import 'package:findmax/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage();
  @override
  _SettingsPage createState() {
    return new _SettingsPage();
  }
}

class _SettingsPage extends State<SettingsPage> {
  
  Widget _buildWidget() {
     return ListView(children: <Widget>[
      ListTile(
        title: Text("Settings"),
        trailing: Switch(value: false,),
      ),
      ListTile(trailing: MaterialButton(onPressed: (){})),
      MaterialButton(onPressed: (){})]);
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
          appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed:(){Navigator.pop(context);}), elevation: 3, centerTitle: true,backgroundColor: Color.fromRGBO(255, 128, 43, 1), title:Text("Settings",
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
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: false,
          body: ModalProgressHUD(
            child: _buildWidget(),
            inAsyncCall: false,
            color: Colors.orangeAccent,
            dismissible: true,
            progressIndicator: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent)),
          ),
        ));
  }
}
