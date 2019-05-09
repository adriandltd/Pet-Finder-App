import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
  pickerCamera() async {
    print('Camera Picker is called');
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = img;
      proofPic = img;
      setState(() {});
            Navigator.pop(context);

    }
  }

  pickerGallery() async {
    print('Gallery Picker is called');
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = img;
      proofPic = img;
      setState(() {});
      Navigator.pop(context);
    }
  }

  var dogName = TextEditingController();
  var dogDesc = TextEditingController();
  var dogLocation = TextEditingController();
  var dogReward = TextEditingController();
  FocusNode textSecondFocusNode = FocusNode();
  FocusNode textThirdFocusNode = FocusNode();
  FocusNode textFourthFocusNode = FocusNode();
  FocusNode textFifthFocusNode = FocusNode();

  createPost() {}

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.image,
                        size: 100,
                      ),
                      ButtonTheme(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          minWidth: 100.0,
                          height: 40.0,
                          child: RaisedButton(
                              color: Color.fromRGBO(255, 128, 43, 1),
                              child: Text("Gallery",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24)),
                              onPressed: () {
                                pickerGallery();
                              })),
                    ],
                  ),
                  Divider(height: 10,indent: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.camera_alt,
                        size: 100,
                      ),
                      ButtonTheme(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          minWidth: 100.0,
                          height: 40.0,
                          child: RaisedButton(
                              color: Color.fromRGBO(255, 128, 43, 1),
                              child: Text("Camera",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24)),
                              onPressed: () {
                                pickerCamera();
                              })),
                    ],
                  ),
                ],
              ),
            ),
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(255, 194, 43, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 128, 43, 1),
          title: Text('New Post'),
        ),
        body: KeyboardAvoider(
          autoScroll: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                        onFieldSubmitted: (dogName) {
                          FocusScope.of(context)
                              .requestFocus(textSecondFocusNode);
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
                          onFieldSubmitted: (dogDesc) {
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
                          onFieldSubmitted: (dogLocation) {
                            FocusScope.of(context)
                                .requestFocus(textFourthFocusNode);
                          },
                          focusNode: textThirdFocusNode,
                        )),
                    Padding(padding: const EdgeInsets.only(top: 20.0)),
                    Container(
                        width: 325,
                        child: TextFormField(
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          textInputAction: TextInputAction.done,
                          controller: dogReward,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Is there a monetary reward?",
                              contentPadding: EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40))),
                          focusNode: textFourthFocusNode,
                        )),
                    Padding(padding: const EdgeInsets.only(top: 40.0)),
                    Container(
                      child: Center(
                        child: image == null
                            ? Text('No Image to Show ')
                            : Image.file(
                                image,
                                width: 250,
                                height: 250,
                              ),
                      ),
                    ),
                    ButtonTheme(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        minWidth: 30.0,
                        height: 20.0,
                        child: RaisedButton(
                            color: Color.fromRGBO(255, 128, 43, 1),
                            child: Text("Add Image",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10)),
                            onPressed: () {
                              _showDialog();
                            })),
                    Padding(
                        padding: const EdgeInsets.only(
                      top: 5.0,
                    )),
                    ButtonTheme(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        minWidth: 275.0,
                        height: 45.0,
                        child: RaisedButton(
                            color: Color.fromRGBO(255, 128, 43, 1),
                            child: Text("Submit",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                            onPressed: () {
                              createPost();
                              Navigator.pop(context);
                            })),
                  ],
                ),
              ),
            ],
          ),
        ),

        // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Color.fromRGBO(255, 128, 43, 1),
        //   onPressed: pickerCamera,
        //   child: Icon(Icons.camera_alt),
        // ),
      ),
    );
  }
}
