import 'package:app/image.dart';
import 'package:app/user/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String userName;
  String userEmail;
  String useruid;
  String imageURl;
  @override
  void initState() {
    super.initState();
    User user = FirebaseAuth.instance.currentUser;

    userName = user.displayName;
    userEmail = user.email;
    imageURl = user.photoURL;
    useruid = user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Userprof(
        email: userEmail,
        imgurl: imageURl,
        name: userName,
        uniqueid: useruid,
      ),
    );
  }
}

class Userprof extends StatelessWidget {
  final String imgurl, name, email, uniqueid;
  Userprof({this.imgurl, this.name, this.email, this.uniqueid});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[50],
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
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
                image: NetworkImage(imgurl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 30),
          profiledetail("ID :", uniqueid),
          profiledetail("Name :", name),
          profiledetail("Email :", email),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => img()));
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green.withOpacity(0.5),
              ),
              child: Text("Change Image",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
