import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import 'add_slot.dart';
// import 'package:flutter_firebase_series/screens/update_record.dart';

class AMC_Completed extends StatefulWidget {
  const AMC_Completed({Key? key}) : super(key: key);

  @override
  State<AMC_Completed> createState() => _AMC_CompletedState();
}

class _AMC_CompletedState extends State<AMC_Completed> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Accepted');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('Accepted');

  Widget listItem({required Map student}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.green[300],
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(8),
      height: 210,
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
                'Place NAme : ',
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
          Row(
            children: [
              Text(
                'Plan : ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70),
              ),
              Text(
                student['plan'],
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
            'Accept by : ' + student['MName'] + ' TID : ' + student['TID'],
          ),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed"),
        actions: [
          Tooltip(
            message: 'Log Out',
            child: IconButton(
                onPressed: () {
                  AuthController.instance.logout();
                },
                icon: Icon(Icons.logout)),
          )
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
        elevation: 20,
        titleSpacing: 20,
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
// import 'package:flutter/material.dart';
//
// import '../auth_controller.dart';
//
// class AMC_Completed extends StatefulWidget {
//   @override
//   _AMC_CompletedState createState() => _AMC_CompletedState();
// }
//
// class _AMC_CompletedState extends State<AMC_Completed> {
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
//                   curr_team('abc', 9876543210, 395010, 'ABC', '29/11/2022'),
//                   curr_team('abc', 9876543210, 395010, 'asd', '29/11/2022'),
//                   curr_team('abc', 9876543210, 395010, 'asd', '29/11/2022'),
//                   curr_team('abc', 9876543210, 395010, 'asd', '29/11/2022'),
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget curr_team(
//       String l_name, int l_co_n, int pin, String pname, String date) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Container(
//       height: 140,
//       width: w * 98,
//       margin: EdgeInsets.all(8.0),
//       padding: EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: Colors.green[300],
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
//             "  Place Name : $pname ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Date: $date",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget new_team(String l_name, int l_co_n, int pin) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Container(
//       height: h * 0.248,
//       width: w * 98,
//       margin: EdgeInsets.all(8.0),
//       padding: EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: Colors.green[300],
//       ),
//       child: Column(
//         children: <Widget>[
//           Text(
//             "Team $team_Count \n  Leader Name: $l_name \n  Leader Contact No.: $l_co_n \n  Area Pincode: $pin",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               ElevatedButton.icon(
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Colors.green),
//                   foregroundColor:
//                       MaterialStateProperty.all<Color>(Colors.white),
//                 ),
//                 onPressed: () {},
//                 icon: Icon(
//                   // <-- Icon
//                   Icons.done,
//                   size: 24.0,
//                 ),
//                 label: Text('Accept'), // <-- Text
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               ElevatedButton.icon(
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Colors.green),
//                   foregroundColor:
//                       MaterialStateProperty.all<Color>(Colors.white),
//                 ),
//                 onPressed: () {},
//                 icon: Icon(
//                   // <-- Icon
//                   Icons.close,
//                   size: 24.0,
//                 ),
//                 label: Text('Reject'), // <-- Text
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
