import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage();
  @override
  _EditProfilePage createState() {
    return new _EditProfilePage();
  }
}

class _EditProfilePage extends State<EditProfilePage> {
  void checkCredentials() async {
    user = await FirebaseAuth.instance.currentUser();
  }

  var nameCtrl = TextEditingController();
  FirebaseUser user;

  Widget _buildWidget() {
    checkCredentials();
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
          Color.fromRGBO(255, 212, 109, 1), //Yellow
          Color.fromRGBO(255, 200, 70, 1),
          Color.fromRGBO(255, 194, 43, 1),
        ],
      )),
      child: ListView(children: <Widget>[
        Padding(padding: const EdgeInsets.only(top: 45.0)),
        ListTile(
          title: Text(
            "Change Display Name",
            style: TextStyle(fontSize: 25, color: Colors.black54),
          ),
          leading: Icon(
            Icons.person,
            size: 40,
            color: Colors.black87,
          ),
          onTap: () {
            showDialog<bool>(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text('Please Enter New Name'),
                  content: Card(
                    color: Colors.transparent,
                    elevation: 0.0,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: nameCtrl,
                          decoration: InputDecoration(
                              labelText: "Name",
                              filled: true,
                              fillColor: Colors.grey.shade50),
                        ),
                        Padding(padding: const EdgeInsets.only(top: 15.0)),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          color: Colors.orangeAccent[700],
                          child: Text('Submit',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            FirebaseAuth.instance.currentUser().then((val) {
                              UserUpdateInfo updateUser = UserUpdateInfo();
                              if (nameCtrl.text.isNotEmpty) {
                                updateUser.displayName = nameCtrl.text;
                                //updateUser.photoUrl = picURL;
                                val.updateProfile(updateUser);

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
                                          "Name successfully update!",
                                          style: TextStyle(fontSize: 24),
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            color: Colors.orangeAccent[700],
                                            child: Text('Ok',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              } else {
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
                                          "Name can't be empty.",
                                          style: TextStyle(fontSize: 24),
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            color: Colors.orangeAccent[700],
                                            child: Text('Ok',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        Padding(padding: const EdgeInsets.only(top: 30.0)),
        ListTile(
          title: Text(
            "Change Email",
            style: TextStyle(fontSize: 25, color: Colors.black54),
          ),
          leading: Icon(
            Icons.email,
            size: 40,
            color: Colors.black87,
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 30.0)),
        ListTile(
          title: Text(
            "Change Password",
            style: TextStyle(fontSize: 25, color: Colors.black54),
          ),
          leading: Icon(
            Icons.vpn_key,
            size: 40,
            color: Colors.black87,
          ),
        ),
      ]),
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
          appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              elevation: 3,
              centerTitle: true,
              backgroundColor: Color.fromRGBO(255, 128, 43, 1),
              title: Text("Edit Profile",
                  style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0.25, 0.25),
                          blurRadius: 12.0,
                          color: Color.fromARGB(185, 0, 0, 0),
                        ),
                      ],
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Myriad'))),
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: false,
          body: _buildWidget(),
        ));
  }
}
