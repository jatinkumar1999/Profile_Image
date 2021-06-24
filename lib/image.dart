import 'dart:io';
import 'dart:math';

import 'package:app/user/home.dart';
import 'package:app/user/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class img extends StatefulWidget {
  img({Key key}) : super(key: key);

  @override
  _imgState createState() => _imgState();
}

class _imgState extends State<img> {
  File image;
  final picker = ImagePicker();
  firebase_storage.Reference ref;
  dynamic chooseimage;

  Future getImage() async {
    final pickedfiles = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedfiles.path);
    });
  }

  uplaodimage() async {
    var randomno = Random(25);
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('profilepics/${randomno.nextInt(5000).toString()}.png');
    await ref.putFile(image).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        DatabaseMethods().profilepic(value).then((val) async {
          await Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
        });
      });
    });
  }

  @override
  void initState() {
    User user = FirebaseAuth.instance.currentUser;
    chooseimage = user.photoURL;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: image == null ? getchoosebtn() : getuploadbtn(),
    );
  }

  getchoosebtn() {
    return Column(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 80),
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 15,
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(chooseimage),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: getImage,
          child: Container(
            width: 100,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.green),
            child: Text("choose Image",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }

  getuploadbtn() {
    return Column(
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
                    fit: BoxFit.cover, image: FileImage(File(image.path)))),
          ),
        ),
        SizedBox(height: 30),
        GestureDetector(
          onTap: uplaodimage,
          child: Container(
            width: 100,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.grey),
            child: Text("Update Image",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }
}
