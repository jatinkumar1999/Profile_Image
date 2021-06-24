import 'dart:io';
import 'package:app/views/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class ChooseImage extends StatefulWidget {
  ChooseImage({Key key}) : super(key: key);

  @override
  _ChooseImageState createState() => _ChooseImageState();
}

CollectionReference imageRef;

firebase_storage.Reference ref;
File image;
final picker = ImagePicker();

class _ChooseImageState extends State<ChooseImage> {
  String imageeurl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 80),
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 15,
                ),
              ],
              image: DecorationImage(
                image: image == null
                    ? AssetImage('assets/img.jpg')
                    : FileImage(
                        File(
                          image.path,
                        ),
                      ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Jatin Kumar",
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(
          height: 10,
        ),
        RaisedButton(
            onPressed: () {
              chooseImage();
            },
            child: Text("choose Image")),
        RaisedButton(
            onPressed: () {
              uploadImage();
            },
            child: Text("Upload"))
      ],
    ));
  }

  chooseImage() async {
    final pickedfiles = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedfiles.path);
    });
    if (pickedfiles.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        image = File(response.file.path);
      });
    } else {
      print(response.file);
    }
  }

  Future<void> uploadImage() async {
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("images//${Path.basename(image.path)}");
    await ref.putData(image.readAsBytesSync()).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        User user = FirebaseAuth.instance.currentUser;
      });
    });
  }
}
