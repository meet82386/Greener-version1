import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:greener_v1/Citizen/homepage.dart';
import 'package:http/http.dart' as http;

import '../controllers/auth_controller.dart';
import '../user.dart';
import 'add_slot.dart';
// import 'package:flutter_firebase_series/screens/update_record.dart';

class AMC_Home extends StatefulWidget {
  const AMC_Home({Key? key}) : super(key: key);

  @override
  State<AMC_Home> createState() => AMC_HomeState();
}

class AMC_HomeState extends State<AMC_Home> {
  int accept = 0, delete = 0;

  String mname = "";

  String tid = "";

  var token = HomePageState().getToken.toString();
  void sendPushmessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAS0spKYE:APA91bGl_melbX4I_jj5GSi2FlumbYuX_Kivmbbp2ifpruF7qQwWtDNYksFEJC14HxLDYYiCoadztRQE6C0ET4p85zpWvvKBGva03UwNYwPF8gWMp0c1XW6NkfK2lfPhE6yHwkm2aUsY'
        },
        body: jsonEncode(<String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'click-action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'body': body,
            'title': title,
          },
          "notification": <String, dynamic>{
            "title": title,
            "body": body,
            "android_channel_id": "Greener"
          },
          "to": token,
        }),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void getData() async {
    var user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    setState(() {
      mname = vari.data()!['fname'];
      tid = vari.data()!['mobile'];
    });
  }

  int free = 0, subscription = 0, total = 0;
  getPlan() async {
    //return FirebaseFirestore.instance.collection('users').doc(userId).get();
    final vari = await FirebaseFirestore.instance
        .collection('counter')
        .doc('Zc46be3BLL4nniTDk72R')
        .get();
    setState(() {
      free = vari.data()!['free'];
      subscription = vari.data()!['paid'];
      accept = vari.data()!['accepted'];
      delete = vari.data()!['deleted'];
      total = free - accept - delete;
    });
    return 1;
  }

  // void initState(){
  //   getData();
  //   super.initState();
  // }

  var mobile_number;

  var dbRef = FirebaseDatabase.instance.ref().child('AskToPlant');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('AskToPlant');

  late DatabaseReference dRef;

  CollectionReference users = FirebaseFirestore.instance.collection('Accepted');

  late DatabaseReference ref;

  CollectionReference user = FirebaseFirestore.instance.collection('Deleted');

  late DatabaseReference noti;
  CollectionReference use =
      FirebaseFirestore.instance.collection('mobile_number');

  late DatabaseReference place;
  CollectionReference pl = FirebaseFirestore.instance.collection('place otp');

  CollectionReference otp = FirebaseFirestore.instance.collection('place otp');

  // final noti = FirebaseDatabase.instance.ref('mobile_number');

  @override
  void initState() {
    getData();
    getPlan();
    super.initState();
    dRef = FirebaseDatabase.instance.ref().child('Accepted');
    ref = FirebaseDatabase.instance.ref().child('Deleted');
    noti = FirebaseDatabase.instance.ref().child('mobile_number');
    place = FirebaseDatabase.instance.ref().child('place otp');
  }

  @override
  Widget listItem({required Map student}) {
    String name = student['Name'];
    String PlaceName = student['PlaceName'];
    String date = student['date'];
    String email = student['email'];
    String mobile_number = student['mobile_number'];
    String time_slot = student['time_slot'];
    String plan = student['plan'];
    mobile_number = student['mobile_number'];

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
      height: 215,
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
                'Email : ',
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
                'Time : ',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () async {
                  int timestamp = DateTime.now().millisecondsSinceEpoch;
                  sendPushmessage(token, "Your Otp is $timestamp.",
                      " Request Accepted, Now You Can Plant A Tree.");
                  // showAlertDialog(student: student);
                  if (mname != null && tid != null) {
                    Map<String, String> add_new_slot = {
                      'Name': name,
                      'PlaceName': PlaceName,
                      'date': date,
                      'email': email,
                      'mobile_number': mobile_number,
                      'time_slot': time_slot,
                      'plan': plan,
                      'MName': mname,
                      'TID': tid,
                    };

                    dRef.push().set(add_new_slot);

                    var now = new DateTime.now();
                    var formatter = new DateFormat('dd-MM-yyyy');
                    String formattedDate = formatter.format(now);

                    String tdata =
                        DateFormat("hh:mm:ss a").format(DateTime.now());

                    await otp.doc(timestamp.toString()).set({
                      'id': timestamp.toString(),
                      'place': PlaceName,
                    }).then((value) => print('Otp Added'));

                    Map<String, String> mobile = {
                      'Mobile_Number': mobile_number,
                      'Place_Name': PlaceName,
                      'title': 'Your Plantation Request Accepted',
                      'message':
                          'You can Plant a Tree at Place ' + PlaceName + '.',
                      'date': formattedDate,
                      'time': tdata,
                      'otp': timestamp.toString(),
                    };

                    noti.push().set(mobile);

                    Map<String, String> placeotp = {
                      'id': timestamp.toString(),
                      'place': PlaceName,
                    };

                    place.push().set(placeotp);

                    // String datetime = DateTime.now().toString();
                    //
                    // noti.child(datetime).set({
                    //   'Mobile_Number' : mobile_number,
                    //   'Place_Name' : PlaceName,
                    //   'title' : 'Accepted',
                    //   'message' : 'You can Plant a Tree at Place ' + PlaceName + '.',
                    // });

                    reference.child(student['key']).remove();
                    if (plan == 'Free') {
                      await getPlan();
                      free = (free! - 1);
                      accept = accept + 1;
                      var it = await FirebaseFirestore.instance
                          .collection("counter")
                          .doc('Zc46be3BLL4nniTDk72R')
                          .update({'free': free});
                      var it2 = await FirebaseFirestore.instance
                          .collection("counter")
                          .doc('Zc46be3BLL4nniTDk72R')
                          .update({'accepted': accept});
                    }
                    setState(() {});

                    Fluttertoast.showToast(
                        msg: "Request Accepted",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0,
                        backgroundColor: Colors.black38);
                  }
                },
                icon: Icon(
                  // <-- Icon
                  Icons.done,
                  size: 24.0,
                ),
                label: Text('Accept'), // <-- Text
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () async {
                  sendPushmessage(token, "We Are Sorry! ",
                      " Request Rejected, Please Try Again Later.");
                  if (mname != null && tid != null) {
                    Map<String, String> add_new_slot = {
                      'Name': name,
                      'PlaceName': PlaceName,
                      'date': date,
                      'email': email,
                      'mobile_number': mobile_number,
                      'time_slot': time_slot,
                      'plan': plan,
                      'MName': mname,
                      'TID': tid,
                    };

                    ref.push().set(add_new_slot);

                    Map<String, String> mobile = {
                      'Mobile_Number': mobile_number,
                      'Place_Name': PlaceName,
                      'title': 'Your Plantation Request Rejected',
                      'message': 'You Should send Request to an Other Place.',
                    };

                    noti.push().set(mobile);

                    // String datetime = DateTime.now().toString();
                    //
                    // noti.child(datetime).set({
                    //   'Mobile_Number' : mobile_number,
                    //   'Place_Name' : PlaceName,
                    //   'title' : 'Your Plantation Request Rejected',
                    //   'message' : 'You Should send Request to an Other Place.',
                    // });

                    reference.child(student['key']).remove();
                    if (plan == 'Free') {
                      await getPlan();
                      delete = delete + 1;
                      free = (free! - 1);
                      var it = await FirebaseFirestore.instance
                          .collection("counter")
                          .doc('Zc46be3BLL4nniTDk72R')
                          .update({'free': free});
                      var it2 = await FirebaseFirestore.instance
                          .collection("counter")
                          .doc('Zc46be3BLL4nniTDk72R')
                          .update({'deleted': delete});
                    }
                    setState(() {});

                    Fluttertoast.showToast(
                        msg: "Request Rejected",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0,
                        backgroundColor: Colors.black38);
                  }
                },
                icon: Icon(
                  // <-- Icon
                  Icons.close,
                  size: 24.0,
                ),
                label: Text('Reject'), // <-- Text
              ),
            ],
          ),
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
    );
  }

  // @override
  // Widget Premium({required Map student}) {
  //   String name = student['Name'];
  //   String PlaceName = student['PlaceName'];
  //   String date = student['date'];
  //   String email = student['email'];
  //   String mobile_number = student['mobile_number'];
  //   String time_slot = student['time_slot'];
  //   String plan = student['plan'];
  //   return Container(
  //     decoration: BoxDecoration(
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.white.withOpacity(0.5),
  //           spreadRadius: 5,
  //           blurRadius: 7,
  //         ),
  //       ],
  //       color: Colors.green,
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     margin: const EdgeInsets.all(10),
  //     padding: const EdgeInsets.all(8),
  //     height: 210,
  //     // color: Colors.green[300],
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Text(
  //               'Name : ',
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w400,
  //                   color: Colors.white70),
  //             ),
  //             Text(
  //               student['Name'],
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w400,
  //                   color: Colors.white),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 5,
  //         ),
  //         Row(
  //           children: [
  //             Text(
  //               'Place Name : ',
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w400,
  //                   color: Colors.white70),
  //             ),
  //             Text(
  //               student['PlaceName'],
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w400,
  //                   color: Colors.white),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 5,
  //         ),
  //         Row(
  //           children: [
  //             Text(
  //               'Date : ',
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w400,
  //                   color: Colors.white70),
  //             ),
  //             Text(
  //               student['date'],
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w400,
  //                   color: Colors.white),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 5,
  //         ),
  //         Row(
  //           children: [
  //             Text(
  //               'Email : ',
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w400,
  //                   color: Colors.white70),
  //             ),
  //             Text(
  //               student['email'],
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w400,
  //                   color: Colors.white),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 5,
  //         ),
  //         Row(
  //           children: [
  //             Text(
  //               'Mobile Number : ',
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w400,
  //                   color: Colors.white70),
  //             ),
  //             Text(
  //               student['mobile_number'],
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w400,
  //                   color: Colors.white),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 5,
  //         ),
  //         Row(
  //           children: [
  //             Text(
  //               'Time : ',
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w400,
  //                   color: Colors.white70),
  //             ),
  //             Text(
  //               student['time_slot'],
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w400,
  //                   color: Colors.white),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 5,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: <Widget>[
  //             ElevatedButton.icon(
  //               style: ButtonStyle(
  //                 backgroundColor:
  //                     MaterialStateProperty.all<Color>(Colors.white),
  //                 foregroundColor:
  //                     MaterialStateProperty.all<Color>(Colors.green),
  //               ),
  //               onPressed: () async {
  //                 // showAlertDialog(student: student);
  //                 if (mname != null && tid != null) {
  //                   Map<String, String> add_new_slot = {
  //                     'Name': name,
  //                     'PlaceName': PlaceName,
  //                     'date': date,
  //                     'email': email,
  //                     'mobile_number': mobile_number,
  //                     'time_slot': time_slot,
  //                     'plan': plan,
  //                     'MName': mname,
  //                     'TID': tid,
  //                   };
  //
  //                   dRef.push().set(add_new_slot);
  //
  //                   reference.child(student['key']).remove();
  //
  //                   if (plan == 'Subscription') {
  //                     subscription = (subscription! - 1);
  //                     var it = FirebaseFirestore.instance
  //                         .collection("counter")
  //                         .doc('Zc46be3BLL4nniTDk72R')
  //                         .update({'paid': subscription});
  //                     var it2 = FirebaseFirestore.instance
  //                         .collection("counter")
  //                         .doc('Zc46be3BLL4nniTDk72R')
  //                         .update({'accepted': accept + 1});
  //                   }
  //                   setState(() {});
  //
  //                   Fluttertoast.showToast(
  //                       msg: "Request Accepted",
  //                       toastLength: Toast.LENGTH_SHORT,
  //                       gravity: ToastGravity.BOTTOM,
  //                       timeInSecForIosWeb: 1,
  //                       textColor: Colors.white,
  //                       fontSize: 16.0,
  //                       backgroundColor: Colors.black38);
  //
  //                   accept = accept + 1;
  //                 }
  //               },
  //               icon: Icon(
  //                 // <-- Icon
  //                 Icons.done,
  //                 size: 24.0,
  //               ),
  //               label: Text('Accept'), // <-- Text
  //             ),
  //             SizedBox(
  //               width: 10,
  //             ),
  //             ElevatedButton.icon(
  //               style: ButtonStyle(
  //                 backgroundColor:
  //                     MaterialStateProperty.all<Color>(Colors.white),
  //                 foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
  //               ),
  //               onPressed: () async {
  //                 if (mname != null && tid != null) {
  //                   Map<String, String> add_new_slot = {
  //                     'Name': name,
  //                     'PlaceName': PlaceName,
  //                     'date': date,
  //                     'email': email,
  //                     'mobile_number': mobile_number,
  //                     'time_slot': time_slot,
  //                     'plan': plan,
  //                     'MName': mname,
  //                     'TID': tid,
  //                   };
  //
  //                   ref.push().set(add_new_slot);
  //
  //                   reference.child(student['key']).remove();
  //
  //                   if (plan == 'Subscription') {
  //                     subscription = (subscription! - 1);
  //                     var it = FirebaseFirestore.instance
  //                         .collection("counter")
  //                         .doc('Zc46be3BLL4nniTDk72R')
  //                         .update({'paid': subscription});
  //                     var it2 = FirebaseFirestore.instance
  //                         .collection("counter")
  //                         .doc('Zc46be3BLL4nniTDk72R')
  //                         .update({'deleted': delete + 1});
  //                   }
  //                   setState(() {});
  //
  //                   Fluttertoast.showToast(
  //                       msg: "Request Rejected",
  //                       toastLength: Toast.LENGTH_SHORT,
  //                       gravity: ToastGravity.BOTTOM,
  //                       timeInSecForIosWeb: 1,
  //                       textColor: Colors.white,
  //                       fontSize: 16.0,
  //                       backgroundColor: Colors.black38);
  //
  //                   delete = delete + 1;
  //                 }
  //               },
  //               icon: Icon(
  //                 // <-- Icon
  //                 Icons.close,
  //                 size: 24.0,
  //               ),
  //               label: Text('Reject'), // <-- Text
  //             ),
  //           ],
  //         ),
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
  //       ],
  //     ),
  //   );
  // }

  Widget null_w() {
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    getPlan();
    return
        // DefaultTabController(
        // length: 1,
        // child:
        Scaffold(
      appBar: AppBar(
        title: Text("AMC Team"),
        backgroundColor: Colors.green,
        actions: [
          Center(
            child: Text(
              "Total: $total",
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
          // Tooltip(
          //   message: 'Log Out',
          //   child: IconButton(
          //       onPressed: () {
          //         AuthController.instance.logout();
          //       },
          //       icon: Icon(Icons.logout)),
          // ),
        ],
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [Colors.green, Colors.lightGreen],
        //       begin: Alignment.bottomRight,
        //       end: Alignment.topLeft,
        //     ),
        //   ),
        // ),
        // bottom: TabBar(
        //   //isScrollable: true,
        //   indicatorColor: Colors.white,
        //   indicatorWeight: 5,
        //   tabs: [
        //     Tab(icon: Icon(Icons.free_cancellation), text: 'Free: $free'),
        //     // Tab(
        //     //     icon: Icon(Icons.workspace_premium),
        //     //     text: 'Premium: $subscription'),
        //   ],
        // ),
        // elevation: 20,
        // titleSpacing: 20,
      ),
      body:
          // TabBarView(
          //   children: [
          Container(
        color: Colors.green[200],
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map student = snapshot.value as Map;
            student['key'] = snapshot.key;

            return (student['plan'] == 'Free')
                ? listItem(student: student)
                : null_w();
          },
        ),
      ),
      // Container(
      //   color: Colors.green[200],
      //   height: double.infinity,
      //   child: FirebaseAnimatedList(
      //     query: dbRef,
      //     itemBuilder: (BuildContext context, DataSnapshot snapshot,
      //         Animation<double> animation, int index) {
      //       Map student = snapshot.value as Map;
      //       student['key'] = snapshot.key;
      //       return (student['plan'] == 'Subscription')
      //           ? Premium(student: student)
      //           : null_w();
      //
      //       // return listItem(student: student);
      //     },
      //   ),
      // ),
      //   ],
      // ),
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Add New Slot',
      //   backgroundColor: Colors.green,
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => Add_Slot()));
      //   },
      //   child: Icon(Icons.add),
      // ),
      // ),
    );
  }

// showAlertDialog({required Map student}) {
//
//   // set up the buttons
//   Widget cancelButton = TextButton(
//     child: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 20),),
//     onPressed:  () {
//       Navigator.of(context).pop(false);
//     },
//   );
//   Widget continueButton = TextButton(
//     child: Text("Continue", style: TextStyle(color: Colors.white, fontSize: 20),),
//     onPressed:  () {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => a(name: student['name'], placename: student['PlaceName'], date: student['date'], email: student['email'], mobile: student['mobile_number'], time: student['time_slot'],)));
//     },
//   );
//
//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     backgroundColor: Colors.green[200],
//     title: Text("Accept Request"),
//     content: Text("Would you like to continue learning how to use Flutter alerts?"),
//     actions: [
//       cancelButton,
//       continueButton,
//     ],
//   );
//
//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }
}

// // import 'package:appbar_example/main.dart';
// import 'package:flutter/material.dart';
//
// import '../auth_controller.dart';
//
// class AMC_Home extends StatefulWidget {
//   @override
//   _AMC_HomeState createState() => _AMC_HomeState();
// }
//
// class _AMC_HomeState extends State<AMC_Home> {
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
//           bottom: TabBar(
//             //isScrollable: true,
//             indicatorColor: Colors.white,
//             indicatorWeight: 5,
//             tabs: [
//               Tab(icon: Icon(Icons.free_cancellation), text: 'Free'),
//               Tab(icon: Icon(Icons.workspace_premium), text: 'Premium'),
//             ],
//           ),
//           elevation: 20,
//           titleSpacing: 20,
//         ),
//         body: TabBarView(
//           children: [
//             SingleChildScrollView(
//               // child: buildPage("text"),
//               child: Container(
//                 margin: const EdgeInsets.only(left: 4, right: 4, top: 2),
//                 child: Column(
//                     // mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Free('abc', 'Pipal', 9876543210, 395010, 'Mota Varachha'),
//                       Free('abc', 'Pipal', 9876543210, 395010, 'Mota Varachha'),
//                       Free('abc', 'Pipal', 9876543210, 395010, 'Mota Varachha'),
//                       Free('abc', 'Pipal', 9876543210, 395010, 'Mota Varachha'),
//                     ]),
//               ),
//             ),
//             SingleChildScrollView(
//               child: buildPage("text"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildPage(String text) => Center(
//         child: Container(
//           margin: const EdgeInsets.only(left: 4, right: 4, top: 2),
//           child: Column(
//               // mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Premium('name', 'Neem', 123456, 1234567890, 'Bardoli',
//                     '29/11/2022', '11:00 AM'),
//                 Premium('name', 'Neem', 123456, 1234567890, 'Bardoli',
//                     '29/11/2022', '11:00 AM'),
//                 Premium('name', 'Neem', 123456, 1234567890, 'Bardoli',
//                     '29/11/2022', '11:00 AM'),
//                 Premium('name', 'Neem', 123456, 1234567890, 'Bardoli',
//                     '29/11/2022', '11:00 AM'),
//               ]),
//         ),
//         // ),
//       );
//
//   Widget Free(String name, String T_name, int pin, int pno, String P_name) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Container(
//       height: 200,
//       width: w * 98,
//       margin: EdgeInsets.all(8.0),
//       padding: EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: Colors.green[300],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             "  Name : $name ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Tree Name : $T_name ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Leader Contact No.: $pno ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Area Pincode: $pin ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Place Name : $P_name",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           SizedBox(
//             height: 2,
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
//                 width: 10,
//               ),
//               ElevatedButton.icon(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
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
//
//   Widget Premium(String name, String T_name, int pin, int pno, String P_name,
//       String date, String time) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Container(
//       height: 250,
//       width: w * 98,
//       margin: EdgeInsets.all(8.0),
//       padding: EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: Colors.green[300],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             "  Name : $name ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Tree Name : $T_name ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Leader Contact No.: $pno ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Area Pincode: $pin ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Place Name : $P_name ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Date : $date ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Time : $time",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           SizedBox(
//             height: 2,
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
//                 width: 10,
//               ),
//               ElevatedButton.icon(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
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

// // import 'package:appbar_example/main.dart';
// import 'package:flutter/material.dart';
//
// import '../controllers/auth_controller.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
//
// class AMC_Home extends StatefulWidget {
//   @override
//   _AMC_HomeState createState() => _AMC_HomeState();
// }
//
// class _AMC_HomeState extends State<AMC_Home> {
//   Query dbRef = FirebaseDatabase.instance.ref().child('AskToPlant');
//
//   // DatabaseReference reference =
//   //     FirebaseDatabase.instance.ref().child('AskToPlant');
//
//   int free = 2;
//   int sub = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: Colors.green[200],
//         appBar: AppBar(
//           title: Text("AMC Team"),
//           backgroundColor: Colors.green,
//           // actions: [
//           //   Tooltip(
//           //     message: 'Log Out',
//           //     child: IconButton(
//           //         onPressed: () {
//           //           AuthController.instance.logout();
//           //         },
//           //         icon: Icon(Icons.logout)),
//           //   )
//           // ],
//           // flexibleSpace: Container(
//           //   decoration: BoxDecoration(
//           //     gradient: LinearGradient(
//           //       colors: [Colors.green, Colors.lightGreen],
//           //       begin: Alignment.bottomRight,
//           //       end: Alignment.topLeft,
//           //     ),
//           //   ),
//           // ),
//           bottom: TabBar(
//             //isScrollable: true,
//             indicatorColor: Colors.white,
//             indicatorWeight: 5,
//             tabs: [
//               Tab(
//                 icon: Icon(Icons.free_cancellation),
//                 text: 'Free: $free',
//               ),
//               Tab(icon: Icon(Icons.workspace_premium), text: 'Premium: $sub'),
//             ],
//           ),
//           // elevation: 20,
//           // titleSpacing: 20,
//         ),
//         // body: Container(
//         //   color: Colors.green[200],
//         //   height: double.infinity,
//         //   child: FirebaseAnimatedList(
//         //     query: dbRef,
//         //     itemBuilder: (BuildContext context, DataSnapshot snapshot,
//         //         Animation<double> animation, int index) {
//         //       Map qu = snapshot.value as Map;
//         //       qu['key'] = snapshot.key;
//         //
//         //       return Free(query1: qu);
//         //     },
//         //   ),
//         // ),
//         // body: buildPagefree('Free'),
//         body: TabBarView(
//           children: [
//             Scaffold(
//               body: Container(
//                 color: Colors.green[200],
//                 height: double.infinity,
//                 child: FirebaseAnimatedList(
//                   query: dbRef,
//                   itemBuilder: (BuildContext context, DataSnapshot snapshot,
//                       Animation<double> animation, int index) {
//                     Map qu = snapshot.value as Map;
//                     qu['key'] = snapshot.key;
//
//                     return (qu['plan'] == 'Free') ? Free(query1: qu) : null_w();
//                   },
//                 ),
//               ),
//             ),
//             Scaffold(
//               body: Container(
//                 color: Colors.green[200],
//                 height: double.infinity,
//                 child: FirebaseAnimatedList(
//                   query: dbRef,
//                   itemBuilder: (BuildContext context, DataSnapshot snapshot,
//                       Animation<double> animation, int index) {
//                     Map qu = snapshot.value as Map;
//                     qu['key'] = snapshot.key;
//                     return (qu['plan'] == 'Subscription')
//                         ? Premium(query1: qu)
//                         : null_w();
//                     return Premium(query1: qu);
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget null_w() {
//     return SizedBox.shrink();
//   }
//
//   Widget Free({required Map query1}) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Container(
//       height: 230,
//       width: w * 98,
//       margin: EdgeInsets.all(8.0),
//       padding: EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.white.withOpacity(0.5),
//             spreadRadius: 5,
//             blurRadius: 7,
//           ),
//         ],
//         color: Colors.green,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             "  Name : " + query1['Name'],
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Tree Name : pipal ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           // Text(
//           //   "  Leader Contact No.: $pno ",
//           //   style: TextStyle(color: Colors.white, fontSize: 20),
//           //   overflow: TextOverflow.ellipsis,
//           // ),
//           // Text(
//           //   "  Area Pincode: 395010 ",
//           //   style: TextStyle(color: Colors.white, fontSize: 20),
//           //   overflow: TextOverflow.ellipsis,
//           // ),
//           Text(
//             "  Place Name :  " + query1['PlaceName'],
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Email :  " + query1['email'],
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Mobile Number :  " + query1['mobile_number'],
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Time Slot :   " + query1['time_slot'],
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           SizedBox(
//             height: 2,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               ElevatedButton.icon(
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Colors.white),
//                   foregroundColor:
//                       MaterialStateProperty.all<Color>(Colors.green),
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
//                 width: 10,
//               ),
//               ElevatedButton.icon(
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Colors.white),
//                   foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
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
//
//   Widget Premium({required Map query1}) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Container(
//       height: 200,
//       width: w * 98,
//       margin: EdgeInsets.all(8.0),
//       padding: EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.white.withOpacity(0.5),
//             spreadRadius: 5,
//             blurRadius: 7,
//           ),
//         ],
//         color: Colors.green,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             "  Name : " + query1['Name'],
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Tree Name : Menduvada ",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           // Text(
//           //   "  Leader Contact No.: pno ",
//           //   style: TextStyle(color: Colors.white, fontSize: 20),
//           //   overflow: TextOverflow.ellipsis,
//           // ),
//           // Text(
//           //   "  Area Pincode: in ",
//           //   style: TextStyle(color: Colors.white, fontSize: 20),
//           //   overflow: TextOverflow.ellipsis,
//           // ),
//           Text(
//             "  Place Name : " + query1['PlaceName'],
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Date : " + query1['PlaceName'],
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             "  Time : " + query1['time_slot'],
//             style: TextStyle(color: Colors.white, fontSize: 20),
//             overflow: TextOverflow.ellipsis,
//           ),
//           SizedBox(
//             height: 2,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               ElevatedButton.icon(
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Colors.white),
//                   foregroundColor:
//                       MaterialStateProperty.all<Color>(Colors.green),
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
//                 width: 10,
//               ),
//               ElevatedButton.icon(
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Colors.white),
//                   foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
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
//
// // // import 'package:appbar_example/main.dart';
// // import 'package:flutter/material.dart';
// //
// // import '../controllers/auth_controller.dart';
// // import 'package:firebase_database/firebase_database.dart';
// // import 'package:firebase_database/ui/firebase_animated_list.dart';
// //
// // class AMC_Home extends StatefulWidget {
// //   @override
// //   _AMC_HomeState createState() => _AMC_HomeState();
// // }
// //
// // class _AMC_HomeState extends State<AMC_Home> {
// //   Query dbRef = FirebaseDatabase.instance.ref().child('AskToPlant');
// //
// //   // DatabaseReference reference =
// //   //     FirebaseDatabase.instance.ref().child('AskToPlant');
// //
// //   int free = 2;
// //   int sub = 0;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     double w = MediaQuery.of(context).size.width;
// //     double h = MediaQuery.of(context).size.height;
// //     return DefaultTabController(
// //       length: 2,
// //       child: Scaffold(
// //         backgroundColor: Colors.green[200],
// //         appBar: AppBar(
// //           title: Text("AMC Team"),
// //           backgroundColor: Colors.green,
// //           // actions: [
// //           //   Tooltip(
// //           //     message: 'Log Out',
// //           //     child: IconButton(
// //           //         onPressed: () {
// //           //           AuthController.instance.logout();
// //           //         },
// //           //         icon: Icon(Icons.logout)),
// //           //   )
// //           // ],
// //           // flexibleSpace: Container(
// //           //   decoration: BoxDecoration(
// //           //     gradient: LinearGradient(
// //           //       colors: [Colors.green, Colors.lightGreen],
// //           //       begin: Alignment.bottomRight,
// //           //       end: Alignment.topLeft,
// //           //     ),
// //           //   ),
// //           // ),
// //           bottom: TabBar(
// //             //isScrollable: true,
// //             indicatorColor: Colors.white,
// //             indicatorWeight: 5,
// //             tabs: [
// //               Tab(
// //                   icon: Icon(Icons.free_cancellation),
// //                   text: 'Free: $free',
// //               ),
// //               Tab(icon: Icon(Icons.workspace_premium), text: 'Premium: $sub'),
// //             ],
// //           ),
// //           // elevation: 20,
// //           // titleSpacing: 20,
// //         ),
// //         // body: Container(
// //         //   color: Colors.green[200],
// //         //   height: double.infinity,
// //         //   child: FirebaseAnimatedList(
// //         //     query: dbRef,
// //         //     itemBuilder: (BuildContext context, DataSnapshot snapshot,
// //         //         Animation<double> animation, int index) {
// //         //       Map qu = snapshot.value as Map;
// //         //       qu['key'] = snapshot.key;
// //         //
// //         //       return Free(query1: qu);
// //         //     },
// //         //   ),
// //         // ),
// //         // body: buildPagefree('Free'),
// //         body: TabBarView(
// //           children: [
// //             Scaffold(
// //               body: Container(
// //                 color: Colors.green[200],
// //                 height: double.infinity,
// //                 child: FirebaseAnimatedList(
// //                   query: dbRef,
// //                   itemBuilder: (BuildContext context, DataSnapshot snapshot,
// //                       Animation<double> animation, int index) {
// //                     Map qu = snapshot.value as Map;
// //                     qu['key'] = snapshot.key;
// //
// //                     return (qu['plan'] == 'Free') ? Free(query1: qu) : null_w();
// //                   },
// //                 ),
// //               ),
// //             ),
// //             Scaffold(
// //               body: Container(
// //                 color: Colors.green[200],
// //                 height: double.infinity,
// //                 child: FirebaseAnimatedList(
// //                   query: dbRef,
// //                   itemBuilder: (BuildContext context, DataSnapshot snapshot,
// //                       Animation<double> animation, int index) {
// //                     Map qu = snapshot.value as Map;
// //                     qu['key'] = snapshot.key;
// //                     return (qu['plan'] == 'Subscription')
// //                         ? Premium(query1: qu)
// //                         : null_w();
// //                     return Premium(query1: qu);
// //                   },
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget null_w() {
// //     return SizedBox.shrink();
// //   }
// //
// //   Widget Free({required Map query1}) {
// //     double w = MediaQuery.of(context).size.width;
// //     double h = MediaQuery.of(context).size.height;
// //     return Container(
// //       height: 230,
// //       width: w * 98,
// //       margin: EdgeInsets.all(8.0),
// //       padding: EdgeInsets.all(8.0),
// //       decoration: BoxDecoration(
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.white.withOpacity(0.5),
// //             spreadRadius: 5,
// //             blurRadius: 7,
// //           ),
// //         ],
// //         color: Colors.green,
// //         borderRadius: BorderRadius.circular(10),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: <Widget>[
// //           Text(
// //             "  Name : " + query1['Name'],
// //             style: TextStyle(color: Colors.white, fontSize: 20),
// //             overflow: TextOverflow.ellipsis,
// //           ),
// //           Text(
// //             "  Tree Name : pipal ",
// //             style: TextStyle(color: Colors.white, fontSize: 20),
// //             overflow: TextOverflow.ellipsis,
// //           ),
// //           // Text(
// //           //   "  Leader Contact No.: $pno ",
// //           //   style: TextStyle(color: Colors.white, fontSize: 20),
// //           //   overflow: TextOverflow.ellipsis,
// //           // ),
// //           // Text(
// //           //   "  Area Pincode: 395010 ",
// //           //   style: TextStyle(color: Colors.white, fontSize: 20),
// //           //   overflow: TextOverflow.ellipsis,
// //           // ),
// //           Text(
// //             "  Place Name :  " + query1['PlaceName'],
// //             style: TextStyle(color: Colors.white, fontSize: 20),
// //             overflow: TextOverflow.ellipsis,
// //           ),
// //           Text(
// //             "  Email :  " + query1['email'],
// //             style: TextStyle(color: Colors.white, fontSize: 20),
// //             overflow: TextOverflow.ellipsis,
// //           ),
// //           Text(
// //             "  Mobile Number :  " + query1['mobile_number'],
// //             style: TextStyle(color: Colors.white, fontSize: 20),
// //             overflow: TextOverflow.ellipsis,
// //           ),
// //           Text(
// //             "  Time Slot :   " + query1['time_slot'],
// //             style: TextStyle(color: Colors.white, fontSize: 20),
// //             overflow: TextOverflow.ellipsis,
// //           ),
// //           SizedBox(
// //             height: 2,
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: <Widget>[
// //               ElevatedButton.icon(
// //                 style: ButtonStyle(
// //                   backgroundColor:
// //                       MaterialStateProperty.all<Color>(Colors.white),
// //                   foregroundColor:
// //                       MaterialStateProperty.all<Color>(Colors.green),
// //                 ),
// //                 onPressed: () {},
// //                 icon: Icon(
// //                   // <-- Icon
// //                   Icons.done,
// //                   size: 24.0,
// //                 ),
// //                 label: Text('Accept'), // <-- Text
// //               ),
// //               SizedBox(
// //                 width: 10,
// //               ),
// //               ElevatedButton.icon(
// //                 style: ButtonStyle(
// //                   backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
// //                   foregroundColor:
// //                       MaterialStateProperty.all<Color>(Colors.red),
// //                 ),
// //                 onPressed: () {},
// //                 icon: Icon(
// //                   // <-- Icon
// //                   Icons.close,
// //                   size: 24.0,
// //                 ),
// //                 label: Text('Reject'), // <-- Text
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget Premium({required Map query1}) {
// //     double w = MediaQuery.of(context).size.width;
// //     double h = MediaQuery.of(context).size.height;
// //     return Container(
// //       height: 200,
// //       width: w * 98,
// //       margin: EdgeInsets.all(8.0),
// //       padding: EdgeInsets.all(8.0),
// //       decoration: BoxDecoration(
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.white.withOpacity(0.5),
// //             spreadRadius: 5,
// //             blurRadius: 7,
// //           ),
// //         ],
// //         color: Colors.green,
// //         borderRadius: BorderRadius.circular(10),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: <Widget>[
// //           Text(
// //             "  Name : " + query1['Name'],
// //             style: TextStyle(color: Colors.white, fontSize: 20),
// //             overflow: TextOverflow.ellipsis,
// //           ),
// //           Text(
// //             "  Tree Name : Menduvada ",
// //             style: TextStyle(color: Colors.white, fontSize: 20),
// //             overflow: TextOverflow.ellipsis,
// //           ),
// //           // Text(
// //           //   "  Leader Contact No.: pno ",
// //           //   style: TextStyle(color: Colors.white, fontSize: 20),
// //           //   overflow: TextOverflow.ellipsis,
// //           // ),
// //           // Text(
// //           //   "  Area Pincode: in ",
// //           //   style: TextStyle(color: Colors.white, fontSize: 20),
// //           //   overflow: TextOverflow.ellipsis,
// //           // ),
// //           Text(
// //             "  Place Name : " + query1['PlaceName'],
// //             style: TextStyle(color: Colors.white, fontSize: 20),
// //             overflow: TextOverflow.ellipsis,
// //           ),
// //           Text(
// //             "  Date : " + query1['PlaceName'],
// //             style: TextStyle(color: Colors.white, fontSize: 20),
// //             overflow: TextOverflow.ellipsis,
// //           ),
// //           Text(
// //             "  Time : " + query1['time_slot'],
// //             style: TextStyle(color: Colors.white, fontSize: 20),
// //             overflow: TextOverflow.ellipsis,
// //           ),
// //           SizedBox(
// //             height: 2,
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: <Widget>[
// //               ElevatedButton.icon(
// //                 style: ButtonStyle(
// //                   backgroundColor:
// //                       MaterialStateProperty.all<Color>(Colors.white),
// //                   foregroundColor:
// //                       MaterialStateProperty.all<Color>(Colors.green),
// //                 ),
// //                 onPressed: () {},
// //                 icon: Icon(
// //                   // <-- Icon
// //                   Icons.done,
// //                   size: 24.0,
// //                 ),
// //                 label: Text('Accept'), // <-- Text
// //               ),
// //               SizedBox(
// //                 width: 10,
// //               ),
// //               ElevatedButton.icon(
// //                 style: ButtonStyle(
// //                   backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
// //                   foregroundColor:
// //                       MaterialStateProperty.all<Color>(Colors.red),
// //                 ),
// //                 onPressed: () {},
// //                 icon: Icon(
// //                   // <-- Icon
// //                   Icons.close,
// //                   size: 24.0,
// //                 ),
// //                 label: Text('Reject'), // <-- Text
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
