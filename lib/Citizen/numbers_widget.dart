import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NumbersWidget extends StatefulWidget {

  @override
  State<NumbersWidget> createState() => _NumbersWidgetState();
}

class _NumbersWidgetState extends State<NumbersWidget> {
  // AnimatedContainer = _controller;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      // StreamBuilder(
      //   stream: FirebaseFirestore.instance.collection("users").where("email", isEqualTo: currentUser.currentUser!.email).snapshots(),
      //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
      //       if(!snapshot.hasData){
      //         return Text("no value");
      //       }
      //       return ListView(
      //         children: snapshot.data.documents.map((document){
      //           return Text(document['email']);
      //         }).toList(),
      //       );
      //     }
      // ),
      buildButton(context, '4', 'Trees Planted'),
      buildDivider(),
      buildButton(context, '35', 'People View Your Profile'),
      buildDivider(),
      buildButton(context, '50', 'Scan Your Tree'),
    ],
  );

  Widget buildDivider() => Container(
    height: 24,
    child: VerticalDivider(),
  );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
}
