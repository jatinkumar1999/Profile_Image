// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:path/path.dart' as Path;

// class AddImage extends StatefulWidget {
//   AddImage({Key key}) : super(key: key);

//   @override
//   _AddImageState createState() => _AddImageState();
// }

// CollectionReference imageRef;
// firebase_storage.Reference ref;
// List<File> image = [];
// final picker = ImagePicker();
// bool isloading = false;
// double val = 0;

// class _AddImageState extends State<AddImage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("AddImage"),
//           actions: [
//             FlatButton(
//                 onPressed: () {
//                   setState(() {
//                     isloading = true;
//                   });
//                   uploadImage().whenComplete(() => Navigator.pop(context));
//                 },
//                 child: Text("Upload"))
//           ],
//         ),
//         body: Stack(
//           children: [
//             GridView.builder(
//               itemCount: image.length + 1,
//               gridDelegate:
//                   SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//               itemBuilder: (context, index) {
//                 return index == 0
//                     ? Center(
//                         child: IconButton(
//                             onPressed: () {
//                               !isloading ? chooseImage() : null;
//                             },
//                             icon: Icon(Icons.add)))
//                     : Container(
//                         margin: EdgeInsets.all(3),
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image: FileImage(
//                                 image[index - 1],
//                               ),
//                               fit: BoxFit.fill),
//                         ),
//                       );
//               },
//             ),
//             isloading
//                 ? Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text("Uploading....",
//                             style: TextStyle(
//                               fontSize: 20.0,
//                               color: Colors.black,
//                             )),
//                         SizedBox(height: 10.0),
//                         CircularProgressIndicator(
//                           value: val,
//                           valueColor:
//                               AlwaysStoppedAnimation<Color>(Colors.green),
//                         )
//                       ],
//                     ),
//                   )
//                 : Container(),
//           ],
//         ));
//   }

//   chooseImage() async {
//     final pickedfiles = await picker.getImage(source: ImageSource.gallery);
//     setState(() {
//       image.add(File(pickedfiles?.path));
//     });
//     if (pickedfiles.path == null) retrieveLostData();
//   }

//   Future<void> retrieveLostData() async {
//     final LostData response = await picker.getLostData();
//     if (response.isEmpty) {
//       return;
//     }
//     if (response.file != null) {
//       setState(() {
//         image.add(File(response.file.path));
//       });
//     } else {
//       print(response.file);
//     }
//   }

//   Future<void> uploadImage() async {
//     int i = 1;
//     for (var img in image) {
//       setState(() {
//         val = i / image.length;
//       });
//       ref = firebase_storage.FirebaseStorage.instance
//           .ref()
//           .child("images//${Path.basename(img.path)}");
//       await ref.putFile(img).whenComplete(() async {
//         await ref.getDownloadURL().then((value) {
//           imageRef.add({"URl": value});
//           i++;
//         });
//       });
//     }
//   }

//   @override
//   void initState() {
//     imageRef = FirebaseFirestore.instance.collection('imagesUrl');
//     super.initState();
//   }
// }
