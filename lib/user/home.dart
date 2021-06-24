import 'package:app/user/userprofile.dart';
import 'package:app/views/chooseimage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    User user = FirebaseAuth.instance.currentUser;

    print(user.displayName);
    print(user.email);
    print(user.photoURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
          ),
        ),
        drawer: Drawer(),
        body: Column(
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => UserProfile()));
              },
              child: Text('chooseimage'),
            )
          ],
        ));
  }
}
