import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../user.dart';
import 'user_preferences.dart';
import 'appbar_widget.dart';
import '../button_widget.dart';
import 'numbers_widget.dart';
import 'profile_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class AMC_Profile extends StatefulWidget {
  @override
  _AMC_ProfileState createState() => _AMC_ProfileState();
}

class _AMC_ProfileState extends State<AMC_Profile> {
  String tid = '';
  String teamName = '';
  String fname = '';
  String lname = '';
  String sdate = '';

  FirebaseAuth auth = FirebaseAuth.instance;
  void getUserFromDBUser() async {
    //return FirebaseFirestore.instance.collection('users').doc(userId).get();

    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: auth.currentUser!.email.toString())
        .get();

    for (var doc in querySnapshot.docs) {
      // Getting data directly
      fname = doc.get('fname');
      teamName = doc.get('team_name');
      tid = doc.get('TeamId').toString();
      lname = doc.get('lname');
      // sdate = doc.get('');
      // Lname = doc.get('lnmae');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    getUserFromDBUser();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        // backgroundColor: Colors.green,
        title: Text(
          "Team Details",
        ),
        actions: [
          Tooltip(
              message: 'Log Out',
              child: IconButton(
                  onPressed: () {
                    AuthController.instance.logout();
                  },
                  icon: Icon(Icons.logout)))
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.lightGreen],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      // buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 24),
          // Center(child: buildUpgradeButton()),
          // const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 24),
          // buildAbout(user),
          // const SizedBox(height: 24),
          // Center(
          //     child: Text(
          //   "Team Details",
          //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          // )),
          // FirebaseAnimatedList(
          //   query: dbRef,
          //   itemBuilder: (BuildContext context, DataSnapshot snapshot,
          //       Animation<double> animation, int index) {
          //     Map student = snapshot.value as Map;
          //     student['key'] = snapshot.key;
          //
          //     return Team_Member();
          //   },
          // ),
          // const SizedBox(height: 24),
          // Center(child: logout()),
        ],
      ),
    );
  }

  Widget buildName() => Column(
        children: [
          Text(
            fname + ' ' + lname,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 10),
          Text(
            'Email : ${auth.currentUser!.email}',
            style: TextStyle(color: Colors.green[900]),
          ),
          Text(
            'Team ID : $tid',
            style: TextStyle(color: Colors.green[900]),
          ),
          Text(
            'Team Name : $teamName',
            style: TextStyle(color: Colors.green[900]),
          ),
          // Text(
          //   'Started Date : $sdate',
          //   style: TextStyle(color: Colors.green[900]),
          // ),
          const SizedBox(height: 30),
        ],
      );

  Widget Team_Leader(String lname, String date, int age) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
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
        height: height * 0.12,
        child: Row(
          children: [
            SizedBox(
              width: 8,
            ),
            Container(
                width: 60,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://images.app.goo.gl/f1m9tXorJtjdhCFy6"),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Leader Name : $lname",
                    style: TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Started Date : $date",
                    style: TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Age : $age",
                    style: TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Team_Member(String mname, String date, int age) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
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
        height: height * 0.12,
        child: Row(
          children: [
            SizedBox(
              width: 8,
            ),
            Container(
                width: 60,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://images.app.goo.gl/f1m9tXorJtjdhCFy6"),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Member Name : $mname",
                    style: TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Joining Date : $date",
                    style: TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Age : $age",
                    style: TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAbout() => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "Dhintanananana",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget logout() => ButtonWidget(
        text: 'Log Out',
        onClicked: () {
          AuthController.instance.logout();
        },
      );
}
