// import 'package:app/addImage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:transparent_image/transparent_image.dart';

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => AddImage()));
//         },
//         child: Icon(Icons.add),
//       ),
//       body: StreamBuilder(
//           stream:
//               FirebaseFirestore.instance.collection('imagesUrl').snapshots(),
//           builder: (context, snapshot) {
//             return !snapshot.hasData
//                 ? Container(
//                     child: Center(child: CircularProgressIndicator()),
//                   )
//                 : GridView.builder(
//                     itemCount: snapshot.data.docs.length,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3),
//                     itemBuilder: (context, index) {
//                       return Container(
//                         margin: EdgeInsets.all(3),
//                         child: FadeInImage.memoryNetwork(
//                           fit: BoxFit.cover,
//                           placeholder: kTransparentImage,
//                           image: snapshot.data.docs[index].get('URl'),
//                         ),
//                       );
//                     });
//           }),
//     );
//   }
// }
