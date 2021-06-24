// import 'package:app/views/chooseimage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:transparent_image/transparent_image.dart';

// class Profile extends StatefulWidget {
//   Profile({Key key}) : super(key: key);

//   @override
//   _ProfileState createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('imagesUrl')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 return !snapshot.hasData
//                     ? Container(
//                         child: Center(child: CircularProgressIndicator()),
//                       )
//                     : Center(
//                         child: Container(
//                         margin: EdgeInsets.only(top: 80),
//                         width: 200,
//                         height: 200,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black,
//                               blurRadius: 15,
//                             ),
//                           ],
//                           image: DecorationImage(
//                               image: NetworkImage(
//                                   snapshot.data.docs[0].get('URl'))),
//                         ),
//                       ));
//               }),
//           SizedBox(
//             height: 30.0,
//           ),
//           RaisedButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => ChooseImage()));
//               },
//               child: Text("choose  Image"))
//         ],
//       ),
//     );
//   }

//   getimagefromfirestore() {
//     FirebaseFirestore.instance.collection('imagesUrl').doc().snapshots();
//   }
// }
