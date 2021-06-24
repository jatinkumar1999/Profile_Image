import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  final userCollection = FirebaseFirestore.instance.collection('users');

  var user = FirebaseAuth.instance.currentUser;

  uploadUserinfo(userMap) {
    FirebaseFirestore.instance.collection('users').add(userMap);
  }

  Future profilepic(photourl) async {
    var user = FirebaseAuth.instance.currentUser;
    user.updateProfile(
      photoURL: photourl,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .where('Uid', isEqualTo: user.uid)
        .get()
        .then((docs) async {
      await FirebaseFirestore.instance
          .doc("/users/${docs.docs[0].id}")
          .update({'URL': photourl}).then((value) {
        print("updated");
      });
    });
  }
}
