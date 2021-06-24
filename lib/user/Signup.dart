import 'package:app/user/home.dart';
import 'package:app/user/login.dart';
import 'package:app/user/services/auth.dart';
import 'package:app/user/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email, password, userName;
  dynamic image =
      "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80";
  signUp() async {
     await AuthServices().signUpWithEmailAndPassword(email, password).then((user) {
      User user = FirebaseAuth.instance.currentUser;
      user.updateProfile(
        displayName: userName,
        photoURL: image,
      );

      Map<String, String> userMap = {
        "Email": email,
        "Password": password,
        "Uid": user.uid,
        "Name": userName,
        'URL': image,
      };
      DatabaseMethods().uploadUserinfo(userMap);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            onChanged: (value) {
              setState(() {
                userName = value;
              });
            },
            decoration: InputDecoration(
              hintText: "userName",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            decoration: InputDecoration(
              hintText: "email",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            decoration: InputDecoration(
              hintText: "password",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                signUp();
              },
              child: Text("SignUp")),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              },
              child: Text("SignIn Page"))
        ],
      )),
    );
  }
}
