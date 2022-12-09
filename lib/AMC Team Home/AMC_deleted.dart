import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../controllers/auth_controller.dart';
import 'add_slot.dart';
// import 'package:flutter_firebase_series/screens/update_record.dart';

class AMC_Deleted extends StatefulWidget {
  const AMC_Deleted({Key? key}) : super(key: key);

  @override
  State<AMC_Deleted> createState() => _AMC_DeletedState();
}

class _AMC_DeletedState extends State<AMC_Deleted> {
  // late FlutterLocalNotificationsPlugin localNotification;
  //
  // @override
  // void initState(){
  //   super.initState();
  //   var androidInitialize = new AndroidInitializationSettings('ic_launcher');
  //
  //   var iOSInitialize = new IOSInitializationSettings();
  //   var initializationSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  //   localNotification = new FlutterLocalNotificationsPlugin();
  //   localNotification.initialize(initializationSettings);
  // }
  //
  // Future _showNotification() async{
  //   var androidDetails = new AndroidNotificationDetails("channelId", "Local Notification", "This is the description of the Notification, you can write anything", importance: Importance.high);
  //   var iosDetails = new IOSNotificationDetails();
  //   var generalNotificationDetails = new NotificationDetails(android: androidDetails, iOS: iosDetails);
  //   await localNotification.show(0, 'Notif title', 'The body of the Notification', generalNotificationDetails);
  // }

  var dbRef = FirebaseDatabase.instance.ref().child('Deleted');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('Deleted');

  int? count;
  getPlan() async {
    //return FirebaseFirestore.instance.collection('users').doc(userId).get();
    final vari = await FirebaseFirestore.instance
        .collection('counter')
        .doc('Zc46be3BLL4nniTDk72R')
        .get();
    setState(() {
      count = vari.data()!['deleted'];
    });
    return 1;
  }

  Widget listItem({required Map student}) {
    String email = student['email'];
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
      height: 205,
      // color: Colors.green[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Name : ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70),
              ),
              Text(
                student['Name'],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                'Place Name : ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70),
              ),
              Text(
                student['PlaceName'],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                'Date : ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70),
              ),
              Text(
                student['date'],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                'email : ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70),
              ),
              Text(
                student['email'],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                'Mobile Number : ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70),
              ),
              Text(
                student['mobile_number'],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          // Row(
          //   children: [
          //     Text(
          //       'Plan : ',
          //       style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w400,
          //           color: Colors.white70),
          //     ),
          //     Text(
          //       student['plan'],
          //       style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w400,
          //           color: Colors.white),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 5,
          // ),
          Row(
            children: [
              Text(
                'Time Slot : ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70),
              ),
              Text(
                student['time_slot'],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Delete by : ' + student['MName'] + ' TID : ' + student['TID'],
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          // Center(
          //   child: TextButton(
          //     style: ButtonStyle(
          //       backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          //       foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
          //     ),
          //     onPressed: () async {
          //       // String msg = 'Slot is Available now !!!';
          //       // String body = 'You can Plant a Tree.';
          //       //
          //       // sendPushMessage(email, msg, body);
          //     },
          //     child: Text('Send Available Notification'),
          //   ),
          // )
          // const SizedBox(
          //   height: 5,
          // ),
          // Row(
          //   children: [
          //     Text(
          //       'Team Member ID : ',
          //       style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w400,
          //           color: Colors.white70),
          //     ),
          //     Text(
          //       student['tid'],
          //       style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w400,
          //           color: Colors.white),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 5,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateRecord(studentKey: student['key'])));
          //       },
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.edit,
          //             color: Theme.of(context).primaryColor,
          //           ),
          //         ],
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 6,
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         reference.child(student['key']).remove();
          //       },
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.delete,
          //             color: Colors.red[700],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getPlan();
    return Scaffold(
      appBar: AppBar(
        title: Text("Deleted"),
        backgroundColor: Colors.green,
        actions: [
      Center(
      child: Text(
      "Total: $count  ",
        style: TextStyle(
          // fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    )
    ]
        // actions: [
        //   Tooltip(
        //     message: 'Log Out',
        //     child: IconButton(
        //         onPressed:
        //             // _showNotification,
        //             () {
        //           AuthController.instance.logout();
        //         },
        //         icon: Icon(Icons.logout)),
        //   )
        // ],
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [Colors.green, Colors.lightGreen],
        //       begin: Alignment.bottomRight,
        //       end: Alignment.topLeft,
        //     ),
        //   ),
        // ),
        // elevation: 20,
        // titleSpacing: 20,
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

            return listItem(student: student);
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Add New Slot',
      //   backgroundColor: Colors.green,
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => Add_Slot()));
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

// // import 'package:appbar_example/main.dart';
// import 'package:flutter/material.dart';
//
// import 'package:flutter/material.dart';
//
// import '../auth_controller.dart';
//
// class AMC_Deleted extends StatefulWidget {
//   @override
//   _AMC_DeletedState createState() => _AMC_DeletedState();
// }
//
// class _AMC_DeletedState extends State<AMC_Deleted> {
//   @override
//   var lName = "Watch";
//   var l_No = 1234567890;
//   var pincode = 123456;
//   var tree_count = 123;
//   var team_Count = 1;
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: Colors.green[200],
//         appBar: AppBar(
//           title: Text("AMC Team"),
//           actions: [
//             Tooltip(
//               message: 'Log Out',
//               child: IconButton(
//                   onPressed: () {
//                     AuthController.instance.logout();
//                   },
//                   icon: Icon(Icons.logout)),
//             )
//           ],
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.green, Colors.lightGreen],
//                 begin: Alignment.bottomRight,
//                 end: Alignment.topLeft,
//               ),
//             ),
//           ),
//           elevation: 20,
//           titleSpacing: 20,
//         ),
//         body: SingleChildScrollView(
//           // child: buildPage("text"),
//           child: Container(
//             margin: const EdgeInsets.only(left: 4, right: 4, top: 2),
//             child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   delete('abc', 9876543210, 395010, 'ABC circle'),
//                   delete('abc', 9876543210, 395010, 'maharana pratap'),
//                   delete('abc', 9876543210, 395010, 'xyz'),
//                   delete('abc', 9876543210, 395010, 'a'),
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget delete(String l_name, int l_co_n, int pin, String pname) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Container(
//       height: 160,
//       width: w * 98,
//       margin: EdgeInsets.all(8.0),
//       padding: EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: Colors.red[300],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "  Name: $l_name ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Contact No.: $l_co_n ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Pincode: $pin ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Place Name: $pname",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           SizedBox(
//             height: 2,
//           ),
//           Center(
//             child: TextButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
//                 foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//               ),
//               onPressed: () {},
//               child: Text('Send Available Notification'),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
