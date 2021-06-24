import 'package:flutter/material.dart';

Widget profiledetail(String headertext, String text) {
  return Container(
      padding: EdgeInsets.only(left: 10),
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(headertext,
                style: TextStyle(fontSize: 18, color: Colors.black45)),
            SizedBox(
              width: 10,
            ),
            Text(text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ],
        ),
      ));
}
