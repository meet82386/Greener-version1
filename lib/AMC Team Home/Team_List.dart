import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import '../user.dart';
import 'add_slot.dart';
// import 'package:flutter_firebase_series/screens/update_record.dart';

class Team_List extends StatefulWidget {
  const Team_List({Key? key}) : super(key: key);

  @override
  State<Team_List> createState() => _Team_ListState();
}

class _Team_ListState extends State<Team_List> {
  var dbRef = FirebaseDatabase.instance.ref().child('Team Members');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('Team Members');

  String imageUrl = '';

  void getData() async {
    var user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get();
    setState(() {
      imageUrl = vari.data()!['profile-image'];
    });
  }

  void initState() {
    getData();
    super.initState();
  }

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
      height: 100,
      // color: Colors.green[300],
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(student['profile-image']),
                  fit: BoxFit.fill),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Name: ',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70),
                  ),
                  Text(
                    student['fname'] + ' ' + student['lname'],
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
                    'Email: ',
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
                    'Team ID: ',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70),
                  ),
                  Text(
                    student['TeamId'].toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AMC Team"),
        backgroundColor: Colors.green,
        // actions: [
        //   Tooltip(
        //     message: 'Log Out',
        //     child: IconButton(
        //         onPressed: () {
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

// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
//
// import '../controllers/auth_controller.dart';
// import 'add_slot.dart';
// // import 'package:flutter_firebase_series/screens/update_record.dart';
//
// class Team_List extends StatefulWidget {
//   const Team_List({Key? key}) : super(key: key);
//
//   @override
//   State<Team_List> createState() => _Team_ListState();
// }
//
// class _Team_ListState extends State<Team_List> {
//   Query dbRef = FirebaseDatabase.instance.ref().child('Team Members');
//   DatabaseReference reference =
//       FirebaseDatabase.instance.ref().child('Team Members');
//
//   Widget listItem({required Map student}) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: Colors.green[300],
//       ),
//       margin: const EdgeInsets.all(10),
//       padding: const EdgeInsets.all(8),
//       height: 100,
//       // color: Colors.green[300],
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 'Owner Name : ',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.white70),
//               ),
//               Text(
//                 student['fname'] + ' ' + student['lname'],
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.white),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Row(
//             children: [
//               Text(
//                 'Owner Contact Number : ',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.white70),
//               ),
//               Text(
//                 student['mobile'],
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.white),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Row(
//             children: [
//               Text(
//                 'Owner Email : ',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.white70),
//               ),
//               Text(
//                 student['TeamId'],
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.white),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           // Row(
//           //   children: [
//           //     Text(
//           //       'Slot Address : ',
//           //       style: TextStyle(
//           //           fontSize: 16,
//           //           fontWeight: FontWeight.w400,
//           //           color: Colors.white70),
//           //     ),
//           //     Text(
//           //       student['slot_address'],
//           //       style: TextStyle(
//           //           fontSize: 16,
//           //           fontWeight: FontWeight.w400,
//           //           color: Colors.white),
//           //     ),
//           //   ],
//           // ),
//           // const SizedBox(
//           //   height: 5,
//           // ),
//           // Row(
//           //   children: [
//           //     Text(
//           //       'Slot Pincode : ',
//           //       style: TextStyle(
//           //           fontSize: 16,
//           //           fontWeight: FontWeight.w400,
//           //           color: Colors.white70),
//           //     ),
//           //     Text(
//           //       student['slot_pincode'],
//           //       style: TextStyle(
//           //           fontSize: 16,
//           //           fontWeight: FontWeight.w400,
//           //           color: Colors.white),
//           //     ),
//           //   ],
//           // ),
//           // const SizedBox(
//           //   height: 5,
//           // ),
//           // Row(
//           //   children: [
//           //     Text(
//           //       'Date : ',
//           //       style: TextStyle(
//           //           fontSize: 16,
//           //           fontWeight: FontWeight.w400,
//           //           color: Colors.white70),
//           //     ),
//           //     Text(
//           //       student['date'],
//           //       style: TextStyle(
//           //           fontSize: 16,
//           //           fontWeight: FontWeight.w400,
//           //           color: Colors.white),
//           //     ),
//           //   ],
//           // ),
//           // const SizedBox(
//           //   height: 5,
//           // ),
//           // Row(
//           //   children: [
//           //     Text(
//           //       'Total Slot : ',
//           //       style: TextStyle(
//           //           fontSize: 16,
//           //           fontWeight: FontWeight.w400,
//           //           color: Colors.white70),
//           //     ),
//           //     Text(
//           //       student['total_slot'],
//           //       style: TextStyle(
//           //           fontSize: 16,
//           //           fontWeight: FontWeight.w400,
//           //           color: Colors.white),
//           //     ),
//           //   ],
//           // ),
//           // const SizedBox(
//           //   height: 5,
//           // ),
//           // Row(
//           //   children: [
//           //     Text(
//           //       'Team Member ID : ',
//           //       style: TextStyle(
//           //           fontSize: 16,
//           //           fontWeight: FontWeight.w400,
//           //           color: Colors.white70),
//           //     ),
//           //     Text(
//           //       student['tid'],
//           //       style: TextStyle(
//           //           fontSize: 16,
//           //           fontWeight: FontWeight.w400,
//           //           color: Colors.white),
//           //     ),
//           //   ],
//           // ),
//           // const SizedBox(
//           //   height: 5,
//           // ),
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.end,
//           //   crossAxisAlignment: CrossAxisAlignment.center,
//           //   children: [
//           //     GestureDetector(
//           //       onTap: () {
//           //         Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateRecord(studentKey: student['key'])));
//           //       },
//           //       child: Row(
//           //         children: [
//           //           Icon(
//           //             Icons.edit,
//           //             color: Theme.of(context).primaryColor,
//           //           ),
//           //         ],
//           //       ),
//           //     ),
//           //     const SizedBox(
//           //       width: 6,
//           //     ),
//           //     GestureDetector(
//           //       onTap: () {
//           //         reference.child(student['key']).remove();
//           //       },
//           //       child: Row(
//           //         children: [
//           //           Icon(
//           //             Icons.delete,
//           //             color: Colors.red[700],
//           //           ),
//           //         ],
//           //       ),
//           //     ),
//           //   ],
//           // )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("AMC Team"),
//         actions: [
//           Tooltip(
//             message: 'Log Out',
//             child: IconButton(
//                 onPressed: () {
//                   AuthController.instance.logout();
//                 },
//                 icon: Icon(Icons.logout)),
//           )
//         ],
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.green, Colors.lightGreen],
//               begin: Alignment.bottomRight,
//               end: Alignment.topLeft,
//             ),
//           ),
//         ),
//         elevation: 20,
//         titleSpacing: 20,
//       ),
//       body: Container(
//         color: Colors.green[200],
//         height: double.infinity,
//         child: FirebaseAnimatedList(
//           query: dbRef,
//           itemBuilder: (BuildContext context, DataSnapshot snapshot,
//               Animation<double> animation, int index) {
//             Map student = snapshot.value as Map;
//             student['key'] = snapshot.key;
//
//             return listItem(student: student);
//           },
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   tooltip: 'Add New Slot',
//       //   backgroundColor: Colors.green,
//       //   onPressed: () {
//       //     Navigator.push(
//       //         context, MaterialPageRoute(builder: (context) => Add_Slot()));
//       //   },
//       //   child: Icon(Icons.add),
//       // ),
//     );
//   }
// }
