import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

var proofPic;

void main() => runApp(new CameraApp());

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  File image;

//  To use Gallery or File Manager to pick Image
//  Comment Line No. 19 and uncomment Line number 20
  picker() async {
    print('Picker is called');
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    File img2 = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = img;
      proofPic = img;
      setState(() {});
    }
  }

  var dogName = TextEditingController();
  var dogDesc = TextEditingController();
  var dogLocation = TextEditingController();
  FocusNode textSecondFocusNode = FocusNode();
  FocusNode textThirdFocusNode = FocusNode();
  FocusNode textFourthFocusNode = FocusNode();
  FocusNode textFifthFocusNode = FocusNode();

  createPost(){
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Picker'),
        ),
        body: Center(
          child: Row(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.only(bottom: 35.0)),
                    Container(
                      width: 325,
                      child: TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: dogName,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Does the dog have a nametag?",
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40))),
                        textCapitalization: TextCapitalization.none,
                        autocorrect: false,
                        onFieldSubmitted: (nameCtrl) {
                          FocusScope.of(context).requestFocus(textSecondFocusNode);
                        },
                      ),
                    ),
                     Padding(padding: const EdgeInsets.only(top: 20.0)),
                  Container(
                      width: 325,
                      child: TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: dogDesc,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Describe the dogs appearence",
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40))),
                        textCapitalization: TextCapitalization.none,
                        autocorrect: false,
                        onFieldSubmitted: (userCtrl) {
                          FocusScope.of(context).requestFocus(textThirdFocusNode);
                        },
                        focusNode: textSecondFocusNode,
                      )),
                       Padding(padding: const EdgeInsets.only(top: 20.0)),
                  Container(
                      width: 325,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: dogLocation,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Where did you find the dog?",
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40))),
                        onFieldSubmitted: (passCtrl) {
                          FocusScope.of(context).requestFocus(textFourthFocusNode);
                        },
                        focusNode: textFifthFocusNode,
                      )),
                   Padding(padding: const EdgeInsets.only(top: 40.0)),
                   Container(
                      child: Center(
                        child: image == null
                            ? Text('No Image to Show ')
                            : Image.file(
                                image,
                                width: 300,
                                height: 300,
                              ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(top: 40.0)),
                  ButtonTheme(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      minWidth: 275.0,
                      height: 45.0,
                      child: RaisedButton(
                          color: Color.fromRGBO(255, 128, 43, 1),
                          child: Text("Submit",
                              style: TextStyle(color: Colors.white, fontSize: 18)),
                          onPressed: () {
                            createPost();
                            Navigator.pop(context);
                          })),
                    ]
                    ,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: picker,
          child: Icon(Icons.camera_alt),
        ),
      ),
    );
  }
}
