import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import 'add_slot.dart';
// import 'package:flutter_firebase_series/screens/update_record.dart';

class AMC_Slot extends StatefulWidget {
  const AMC_Slot({Key? key}) : super(key: key);

  @override
  State<AMC_Slot> createState() => _AMC_SlotState();
}

class _AMC_SlotState extends State<AMC_Slot> {
  Query dbRef = FirebaseDatabase.instance.ref().child('AddNewSlot');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('AddNewSlot');

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
      height: 225,
      // color: Colors.green[300],
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Owner Name : ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70),
              ),
              Text(
                student['owner_name'],
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
                'Owner Contact Number : ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70),
              ),
              Text(
                student['owner_mobile_number'],
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
                'Owner Email : ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70),
              ),
              Text(
                student['owner_email'],
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
                'Slot Address : ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70),
              ),
              Text(
                student['slot_address'],
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
                'Slot Pincode : ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70),
              ),
              Text(
                student['slot_pincode'],
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
                'Total Slot : ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70),
              ),
              Text(
                student['total_slot'],
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
                'Team Member ID : ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70),
              ),
              Text(
                student['tid'],
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
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Slot',
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Add_Slot()));
        },
        child: Icon(Icons.add, color: Colors.green, size: 35,),
      ),
    );
  }
}

// // import 'package:appbar_example/main.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:greener_v1/AMC%20Team%20Home/add_slot.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
//
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
//
// import '../auth_controller.dart';
//
// class AMC_Slot_Details extends StatefulWidget {
//   @override
//   _AMC_Slot_DetailsState createState() => _AMC_Slot_DetailsState();
// }
//
// class _AMC_Slot_DetailsState extends State<AMC_Slot_Details> {
//
//   // var dbRef = FirebaseDatabase.instance.ref.child('add_new_slot');
//
//   final auth = FirebaseAuth.instance;
//   final ref = FirebaseDatabase.instance.ref('AddNewSlot');
//
//   // final databaseRef = FirebaseDatabase.instance.reference().child("AddNewSlot");
//
//
//   // final dbRef = FirebaseDatabase.instance.ref().child('add_new_slot');
//
//   // final emailController = TextEditingController();
//   // final pinController = TextEditingController();
//   // final nameController = TextEditingController();
//   // final addController = TextEditingController();
//   // final mobileController = TextEditingController();
//   // final slotController = TextEditingController();
//   // final tnController = TextEditingController();
//   // final tidController = TextEditingController();
//   //
//   // @override
//   // var lName = "Watch";
//   // var l_No = 1234567890;
//   // var pincode = 123456;
//   // var tree_count = 123;
//   // var team_Count = 1;
//   //
//   // List l=[];
//   //
//   // void add(){
//   //   setState(() {
//   //     l.add([emailController.text, pinController.text, nameController.text, addController.text, mobileController.text]);
//   //   });
//   // }
//
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
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Text('Hello'),
//
//                   // FirebaseAnimatedList(
//                   //     query: databaseRef,
//                   //     itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
//                   //       var x = snapshot.value['owner_name'];
//                   //       return ListTile(
//                   //         subtitle: Text(snapshot.value['owner_name']),
//                   //       );
//                   //     }
//                   // ),
//
//
//                   FirebaseAnimatedList(
//                       query: ref,
//                       itemBuilder: (context, snapshot, animation, index){
//                         return ListTile(
//                           title: Text(snapshot.child('owner_name').value.toString()),
//                           subtitle: Text(snapshot.child('owner_email').value.toString()),
//                         );
//                       }
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   // GestureDetector(
//                   //   onTap: (){
//                   //     Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Slot()));
//                   //   },
//                   //   child: Container(
//                   //     decoration: BoxDecoration(
//                   //       color: Colors.green,
//                   //       borderRadius: BorderRadius.circular(10)
//                   //     ),
//                   //     height: 50,
//                   //     width: w * 0.96,
//                   //     child: Row(
//                   //       mainAxisAlignment: MainAxisAlignment.center,
//                   //       children: [
//                   //         Icon(
//                   //           Icons.add,
//                   //           color: Colors.white,
//                   //         ),
//                   //         SizedBox(
//                   //           width: 10,
//                   //         ),
//                   //         Text(
//                   //           'Add New Slot',
//                   //           style: TextStyle(
//                   //             fontSize: 20,
//                   //             fontWeight: FontWeight.w500,
//                   //             color: Colors.white,
//                   //           ),
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   // SizedBox(height: 300,),
//                   // FirebaseAnimatedList(
//                   //     query: dbRef,
//                   //     itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
//                   //       Map add_new_slot = snapshot.value as Map;
//                   //       add_new_slot['key'] = snapshot.key;
//                   //
//                   //       return org(add_new_slot: add_new_slot);
//                   // },
//                   // ),
//                   // org('abc', 9876543210, 395010, 'Yogichok', 10, 'abc@gmail.com', 'TID12345'),
//                   // org('abc', 9876543210, 395010, 'asd', 1, 'abc@gmail.com', 'TID12345'),
//                   // org('abc', 9876543210, 395010, 'asd', 34, 'abc@gmail.com', 'TID12345'),
//                   // org('abc', 9876543210, 395010, 'asd', 6, 'abc@gmail.com', 'TID12345'),
//                 ]),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           tooltip: 'Add New Slot',
//           backgroundColor: Colors.green,
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Slot()));
//           },
//           child: Icon(Icons.add),
//         ),
//       ),
//     );
//   }
//
//   Widget org({required Map add_new_slot}) {
//     String l_name; int l_co_n; int pin; String address; int slots; String email; String tid;
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Container(
//       height: 185,
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
//             "  Owner Name: $add_new_slot['owner_name'] ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Contact No.: $add_new_slot['owner_mobile_number'] ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Email.: $add_new_slot['owner_email'] ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Address : $add_new_slot['slot_address'] ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Land Pincode: $add_new_slot['slot_pincode'] ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Total Slots: $add_new_slot['total_slot']",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Add by: $add_new_slot['tid']",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
// }
