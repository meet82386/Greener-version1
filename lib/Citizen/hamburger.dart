import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import './profile_info.dart';
import './change_pass.dart';
import 'Profile_Settings.dart';
//import 'Profile_Settings.dart';

class HamBurger extends StatefulWidget {
  @override
  _HamBurgerState createState() => _HamBurgerState();
}

class _HamBurgerState extends State<HamBurger> {
  String fname = "a";
  String lname = "a";
  String email = "a";
  String imageUrl = '';

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
      imageUrl = vari.data()!['profile-image'];
    });
  }

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.green[200],
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Colors.green,
              child: Center(
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
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                            ),
                          Text(
                             '$fname $lname',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                            ),
                          ),
                    Text(
                      email,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            // ListTile(
            //   leading: Icon(Icons.person),
            //   title: Text(
            //     'Profile',
            //     style: TextStyle(
            //       fontSize: 18,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => ProfileInfo(),
            //         ));
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile_Settings(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.password),
              title: Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePass(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text(
                'Privacy',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text(
                'Security',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                AuthController.instance.logout();
              },
            ),
          ],
        ));
  }
}
