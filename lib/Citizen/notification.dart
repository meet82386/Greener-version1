import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
// import 'add_slot.dart';
// import 'package:flutter_firebase_series/screens/update_record.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  var mno;

  void getData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get();
    setState(() {
      mno = vari.data()!['mobile'].toString();
    });
  }

  void initState() {
    getData();
    super.initState();
  }

  var dbRef = FirebaseDatabase.instance.ref().child('mobile_number');
  DatabaseReference reference =
  FirebaseDatabase.instance.ref().child('mobile_number');

  Widget listItem({required Map student}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
          ),
        ],
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(8),
      height: 110,
      // color: Colors.green[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                student['time'],
                style: TextStyle(
                    fontSize: 12,
                    // fontWeight: FontWeight.w500,
                    color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                student['date'],
                style: TextStyle(
                    fontSize: 12,
                    // fontWeight: FontWeight.w500,
                    color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                student['title'],
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
              Text(
                student['message'],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
          ),
          const SizedBox(
            height: 5,
          ),
          student['otp'] != "" ?
            Text(
            "Your Plantation Otp: " + student['otp'],
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ) : SizedBox(height: 1,),
        ],
      ),
    );
  }

  Widget null_w() {
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("AMC Team"),
      ),
      body: Container(
        color: Colors.green[200],
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map student = snapshot.value as Map;
            student['key'] = snapshot.key;

            return (student['Mobile_Number'] == mno)
                ? listItem(student: student)
                : null_w();
          },
        ),
      ),
    );
  }
}
