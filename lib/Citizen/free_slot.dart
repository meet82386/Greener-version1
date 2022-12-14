import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import 'Slot_Login.dart';
// import 'add_slot.dart';
// import 'package:flutter_firebase_series/screens/update_record.dart';

class Plantation extends StatefulWidget {
  const Plantation({Key? key}) : super(key: key);

  @override
  State<Plantation> createState() => _PlantationState();
}

class _PlantationState extends State<Plantation> {
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
      height: 100,
      // color: Colors.green[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "  " + student['slot_address'] + ' Slot Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Total: ' + student['total_slot'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Free: ' + student['free_slot'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                    ),
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     Text(
              //       'Owner Name : ',
              //       style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w400,
              //           color: Colors.white70),
              //     ),
              //     Text(
              //       student['owner_name'],
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
              //   children: [
              //     Text(
              //       'Owner Contact Number : ',
              //       style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w400,
              //           color: Colors.white70),
              //     ),
              //     Text(
              //       student['owner_mobile_number'],
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
              //   children: [
              //     Text(
              //       'Owner Email : ',
              //       style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w400,
              //           color: Colors.white70),
              //     ),
              //     Text(
              //       student['owner_email'],
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
              //   children: [
              //     Text(
              //       'Slot Address : ',
              //       style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w400,
              //           color: Colors.white70),
              //     ),
              //     Text(
              //       student['slot_address'],
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
              //   children: [
              //     Text(
              //       'Slot Pincode : ',
              //       style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w400,
              //           color: Colors.white70),
              //     ),
              //     Text(
              //       student['slot_pincode'],
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
              //   children: [
              //     Text(
              //       'Date : ',
              //       style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w400,
              //           color: Colors.white70),
              //     ),
              //     Text(
              //       student['date'],
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
              //   children: [
              //     Text(
              //       'Total Slot : ',
              //       style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w400,
              //           color: Colors.white70),
              //     ),
              //     Text(
              //       student['total_slot'],
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Slot_Login(
                              area: student['slot_address'])));
                },
                child: Text(
                  'Plant'
                )
            ),
          ),
          // SizedBox(width: 1,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("AMC Team"),
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
// // import '../auth_controller.dart';
// import '../controllers/auth_controller.dart';
// import 'Slot_Login.dart';
// // import 'add_slot.dart';
// // import 'package:flutter_firebase_series/screens/update_record.dart';
//
// class Plantation extends StatefulWidget {
//   const Plantation({Key? key}) : super(key: key);
//
//   @override
//   State<Plantation> createState() => _PlantationState();
// }
//
// class _PlantationState extends State<Plantation> {
//   late bool loading;
//
//   Query dbRef = FirebaseDatabase.instance.ref().child('AddNewSlot');
//   DatabaseReference reference =
//       FirebaseDatabase.instance.ref().child('AddNewSlot');
//
//   // @override
//   // void initState() {
//   //   loading = true;
//   //   Future.delayed(const Duration(seconds: 2), () {
//   //     setState(() {
//   //       loading = false;
//   //     });
//   //   });
//   //   super.initState();
//   // }
//
//   Widget listItem({required Map student}) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     int free_slot = 2;
//     int full_slot = int.parse(student['total_slot']) - free_slot;
//     var color = Colors.red.shade200;
//     var bcolor = Colors.red;
//     if (free_slot == 0) {
//       color = Colors.red.shade200;
//       bcolor = Colors.red;
//     } else {
//       color = Colors.green;
//       bcolor = Colors.blue;
//     }
//     return Expanded(
//       child: Row(
//         children: [
//           Container(
//             height: 100,
//             width: w * 0.95,
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.white.withOpacity(0.5),
//                   spreadRadius: 5,
//                   blurRadius: 7,
//                 ),
//               ],
//               color: Colors.green,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             margin: const EdgeInsets.all(10),
//             padding: const EdgeInsets.all(8),
//             // height: 210,
//             // color: Colors.green[300],
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "  " + student['slot_address'],
//                           style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.white),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Align(
//                             alignment: Alignment.bottomCenter,
//                             child: Text(
//                               "Slot Details",
//                               style:
//                                   TextStyle(fontSize: 17, color: Colors.white),
//                             )),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     // Text("$add",style: TextStyle(fontSize: 18),),
//                     // const Divider(
//                     //   height: 20,
//                     //   thickness: 2,
//                     //   indent: 20,
//                     //   endIndent: 20,
//                     //   color: Colors.black,
//                     // ),
//
//                     // SizedBox(height: 15),
//                     Row(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Total : " + student['total_slot'],
//                               style:
//                                   TextStyle(fontSize: 17, color: Colors.white),
//                             ),
//                             // Text(
//                             //   student['total_slot'],
//                             //   style:
//                             //       TextStyle(fontSize: 17, color: Colors.yellow),
//                             // ),
//                           ],
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           "Free : $free_slot",
//                           style: TextStyle(fontSize: 17, color: Colors.white),
//                         ),
//                         // SizedBox(
//                         //   width: 20,
//                         // ),
//                         // Text("Full : $full_slot",
//                         //     style: TextStyle(
//                         //       fontSize: 17,
//                         //       color: Colors.red,
//                         //     )),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Container(
//                     margin:
//                         EdgeInsets.only(left: 8, top: 25, right: 8, bottom: 5),
//                     child: (color == Colors.green)
//                         ? ElevatedButton(
//                             child: Text("Plant "),
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Slot_Login(
//                                           area: student['slot_address'])));
//                             },
//                             style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStateProperty.all(bcolor)),
//                           )
//                         : Container(
//                             margin: EdgeInsets.only(top: 7),
//                             decoration: BoxDecoration(
//                                 color: Colors.red,
//                                 borderRadius: BorderRadius.circular(5)),
//                             height: 37,
//                             width: 68,
//                             child: Center(
//                                 child: Text(
//                               "Close",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w500),
//                             )),
//                           ))
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     setState(() {});
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Free Slot"),
//         backgroundColor: Colors.green,
//         // actions: [
//         //   Tooltip(
//         //     message: 'Log Out',
//         //     child: IconButton(
//         //         onPressed: () {
//         //           AuthController.instance.logout();
//         //         },
//         //         icon: Icon(Icons.logout)),
//         //   )
//         // ],
//         // flexibleSpace: Container(
//         //   decoration: BoxDecoration(
//         //     gradient: LinearGradient(
//         //       colors: [Colors.green, Colors.lightGreen],
//         //       begin: Alignment.bottomRight,
//         //       end: Alignment.topLeft,
//         //     ),
//         //   ),
//         // ),
//         // elevation: 20,
//         // titleSpacing: 20,
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
//             return listItem(student: student);
//           },
//         ),
//       ),
//     );
//   }
// }
