import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'hamburger.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  String fname = "a";
  String lname = "a";
  String email = "a";
//int mobile=0;
  String birthDate = "a";
  String role = "a";
  void getData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get();
    setState(() {
      fname = vari.data()!['fname'];
      lname = vari.data()!['lname'];
      email = vari.data()!['email'];
      //mobile=vari.data()!['mobile'];
      birthDate = vari.data()!['birthDate'];
      role = vari.data()!['role'];
    });
  }

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Profile"),
      ),

      /*body: Center(
        child: Column(
          children: [
            Text(fname,style: TextStyle(fontSize: 22),),
            Text(lname,style: TextStyle(fontSize: 22),),
          ],
        ),
      ),*/

      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(
                top: 30,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQNvWDvQb_rCtRL-p_w329CtzHmfzfWP0FIw&usqp=CAU'),
                    fit: BoxFit.fill),
              ),
            ),
            Text(
              fname,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 40,
              width: 300,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Container(
              width: 280,
              height: 50,
              margin: EdgeInsets.only(right: 40),
              child: Row(
                children: <Widget>[
                  Icon(Icons.person),
                  Text("  "),
                  Text(
                    'First Name : ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("  "),
                  Text(
                    fname,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              width: 280,
              height: 50,
              margin: EdgeInsets.only(right: 40),
              child: Row(
                children: <Widget>[
                  Icon(Icons.person),
                  Text("  "),
                  Text("  "),
                  Text(
                    'Last Name : ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("  "),
                  Text(
                    lname,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              width: 320,
              height: 50,
              margin: EdgeInsets.only(right: 0, left: 1),
              child: Row(
                children: <Widget>[
                  Icon(Icons.email),
                  Text("  "),
                  Text("  "),
                  Text(
                    'E-mail ID : ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("  "),
                  Text(
                    email,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),

            /* Container(
              width: 280,
              height: 50,
              margin: EdgeInsets.only(right: 40),
              child: Row(
                children: <Widget>[
                  Icon(Icons.contact_phone),Text("  "),
                  Text('Contact No. : ',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),),
                  Spacer(),
                  Text(mobile,style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),)
                ],
              ),
            ),*/

            Container(
              width: 280,
              height: 50,
              margin: EdgeInsets.only(right: 40),
              child: Row(
                children: <Widget>[
                  Icon(Icons.calendar_month),
                  Text("  "),
                  Text("  "),
                  Text(
                    'Birth Date : ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("  "),
                  Text(
                    birthDate,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              width: 280,
              height: 50,
              margin: EdgeInsets.only(right: 40),
              child: Row(
                children: <Widget>[
                  Icon(Icons.format_list_bulleted_rounded),
                  Text("  "),
                  Text("  "),
                  Text(
                    'Role : ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("  "),
                  Text(
                    role,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
