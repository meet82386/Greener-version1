import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:greener_v1/AMC%20Team%20Home/AMC_org_slot.dart';
import '../controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Add_Slot extends StatefulWidget {
  const Add_Slot({Key? key}) : super(key: key);

  @override
  State<Add_Slot> createState() => _Add_SlotState();
}

class _Add_SlotState extends State<Add_Slot> {
  // final Stream<QuerySnapshot> citizenStream =
  // FirebaseFirestore.instance.collection('users').snapshots();
  // String? get email => '';
  // String? get password => '';

  late DatabaseReference dbRef;

  CollectionReference users =
      FirebaseFirestore.instance.collection('AddNewSlot');

  // void add(){
  //   setState(() {
  //     AMC_Slot_Details.add([emailController, pinController, nameController, addController, mobileController]);
  //   });
  // }

  final emailController = TextEditingController();
  final pinController = TextEditingController();
  final nameController = TextEditingController();
  final addController = TextEditingController();
  final mobileController = TextEditingController();
  final slotController = TextEditingController();
  final tnController = TextEditingController();
  final tidController = TextEditingController();

  late String oname, date, email, address, tname, tid;
  late int onumber, pin, nslot;

  String dob = '18-02-2003';

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('AddNewSlot');
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.green[200],
        appBar: AppBar(
          title: Text('Add New Slot'),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   width: w,
              //   height: h*0.3,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage(
              //         "img/tree_PNG104381.png"
              //       ),
              //       fit: BoxFit.cover
              //     )
              //   ),
              // ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Owner Name:",
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[600]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        onChanged: (value) {
                          oname = value;
                        },
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: "Enter Owner Name",
                            // prefixIcon: Icon(Icons.nam, color:Colors.green),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Owner Mobile Number:",
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[600]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        onChanged: (value) {
                          onumber = value as int;
                        },
                        controller: mobileController,
                        decoration: InputDecoration(
                            prefixText: "+91  ",
                            // prefixIcon: Icon(Icons.email, color:Colors.green),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        // keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Owner E-mail:",
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[600]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        onChanged: (value) {
                          email = value;
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: "xyz@gmail.com",
                            // prefixIcon: Icon(Icons.email, color:Colors.green),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: [AutofillHints.email],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Slot Address:",
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[600]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        onChanged: (value) {
                          address = value;
                        },
                        controller: addController,
                        decoration: InputDecoration(
                            hintText: "Enter the Address",
                            // prefixIcon: Icon(Icons.nam, color:Colors.green),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Pincode:",
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[600]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        onChanged: (value) {
                          pin = value as int;
                        },
                        controller: pinController,
                        decoration: InputDecoration(
                            hintText: "Enter the Pincode",
                            // prefixIcon: Icon(Icons.email, color:Colors.green),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        // keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Number of Slot:",
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[600]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        onChanged: (value) {
                          nslot = value as int;
                        },
                        controller: slotController,
                        decoration: InputDecoration(
                            hintText: "Enter the Minimum slot to Plant a Tree",
                            // prefixIcon: Icon(Icons.email, color:Colors.green),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        // keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Slot Add Date:",
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[600]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.green[200]),
                      child: Container(
                        height: 75,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: DateTime(2003, 2, 18),
                          onDateTimeChanged: (DateTime newDateTime) {
                            // Do something
                            dob = DateFormat('dd-MM-yyyy').format(newDateTime);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Team Member Name:",
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[600]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        onChanged: (value) {
                          tname = value;
                        },
                        controller: tnController,
                        decoration: InputDecoration(
                            hintText: "Enter the Team Member Name",
                            // prefixIcon: Icon(Icons.nam, color:Colors.green),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Team Member ID:",
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[600]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        onChanged: (value) {
                          tid = value;
                        },
                        controller: tidController,
                        decoration: InputDecoration(
                            hintText: "Enter the Team Member ID",
                            // prefixIcon: Icon(Icons.nam, color:Colors.green),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       "Password:",
                    //       style:
                    //       TextStyle(fontSize: 20, color: Colors.green[600]),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(20),
                    //       boxShadow: [
                    //         BoxShadow(
                    //             blurRadius: 10,
                    //             spreadRadius: 7,
                    //             offset: Offset(1, 1),
                    //             color: Colors.grey.withOpacity(0.2))
                    //       ]),
                    //   child: TextField(
                    //     controller: passwordController,
                    //     onChanged: (password) => onPasswordChanged(password),
                    //     obscureText: !_isVisible,
                    //     decoration: InputDecoration(
                    //       suffixIcon: IconButton(
                    //         onPressed: () {
                    //           setState(() {
                    //             _isVisible = !_isVisible;
                    //           });
                    //         },
                    //         icon: _isVisible
                    //             ? Icon(
                    //           Icons.visibility,
                    //           color: Colors.green,
                    //         )
                    //             : Icon(
                    //           Icons.visibility_off,
                    //           color: Colors.green,
                    //         ),
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //
                    //         // borderSide: BorderSide(color: Colors.white)
                    //       ),
                    //       // focusedBorder: OutlineInputBorder(
                    //       //     borderRadius: BorderRadius.circular(10),
                    //       //     borderSide: BorderSide(color: Colors.white)),
                    //       focusedBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(20),
                    //           borderSide:
                    //           BorderSide(color: Colors.white, width: 1.0)),
                    //       hintText: "Password",
                    //       contentPadding: EdgeInsets.symmetric(
                    //           horizontal: 20, vertical: 20),
                    //       enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //           borderSide:
                    //           BorderSide(color: Colors.white, width: 1.0)),
                    //     ),
                    //   ),
                    // ),

                    // TextField(
                    //   onChanged: (password) => onPasswordChanged(password),
                    //   obscureText: !_isVisible,
                    //   decoration: InputDecoration(
                    //     suffixIcon: IconButton(
                    //       onPressed: () {
                    //         setState(() {
                    //           _isVisible = !_isVisible;
                    //         });
                    //       },
                    //       icon: _isVisible
                    //           ? Icon(
                    //               Icons.visibility,
                    //               color: Colors.green,
                    //             )
                    //           : Icon(
                    //               Icons.visibility_off,
                    //               color: Colors.green,
                    //             ),
                    //     ),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //
                    //       // borderSide: BorderSide(color: Colors.white)
                    //     ),
                    //     // focusedBorder: OutlineInputBorder(
                    //     //     borderRadius: BorderRadius.circular(10),
                    //     //     borderSide: BorderSide(color: Colors.white)),
                    //     focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(20),
                    //         borderSide:
                    //             BorderSide(color: Colors.white, width: 1.0)),
                    //     hintText: "Password",
                    //     contentPadding:
                    //         EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    //     enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(30),
                    //         borderSide:
                    //             BorderSide(color: Colors.white, width: 1.0)),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Row(
                    //   children: [
                    //     AnimatedContainer(
                    //       duration: Duration(milliseconds: 500),
                    //       width: 20,
                    //       height: 20,
                    //       decoration: BoxDecoration(
                    //           color: _isPasswordEightCharacters
                    //               ? Colors.green
                    //               : Colors.transparent,
                    //           border: _isPasswordEightCharacters
                    //               ? Border.all(color: Colors.transparent)
                    //               : Border.all(color: Colors.grey.shade400),
                    //           borderRadius: BorderRadius.circular(50)),
                    //       child: Center(
                    //         child: Icon(
                    //           Icons.check,
                    //           color: Colors.white,
                    //           size: 15,
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text("Contains at least 8 characters")
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Row(
                    //   children: [
                    //     AnimatedContainer(
                    //       duration: Duration(milliseconds: 500),
                    //       width: 20,
                    //       height: 20,
                    //       decoration: BoxDecoration(
                    //           color: _hasPasswordOneNumber
                    //               ? Colors.green
                    //               : Colors.transparent,
                    //           border: _hasPasswordOneNumber
                    //               ? Border.all(color: Colors.transparent)
                    //               : Border.all(color: Colors.grey.shade400),
                    //           borderRadius: BorderRadius.circular(50)),
                    //       child: Center(
                    //         child: Icon(
                    //           Icons.check,
                    //           color: Colors.white,
                    //           size: 15,
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text("Contains at least 1 number")
                    //   ],
                    // ),
                    // SizedBox(height: 15,),
                    // Row(
                    //   children: [
                    //     Expanded(child: Container(),),
                    //     Text(
                    //       "Forgot Your Password?",
                    //       style: TextStyle(
                    //           fontSize: 18,
                    //           color: Colors.grey[600]
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  Map<String, String> add_new_slot = {
                    'owner_name': nameController.text,
                    'owner_email': emailController.text,
                    'owner_mobile_number': mobileController.text,
                    'slot_address': addController.text,
                    'slot_pincode': pinController.text,
                    'total_slot': slotController.text,
                    'date': '26/11/2002',
                    'team_member_name': tnController.text,
                    'tid': tidController.text
                  };

                  dbRef.push().set(add_new_slot);
                  // _showToast(context);

                  Fluttertoast.showToast(
                      msg: "Slot Added",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0,
                      backgroundColor: Colors.black38
                  );

                  Navigator.pop(context, MaterialPageRoute(builder: (context) => Add_Slot()));
                  // await users.add({
                  //
                  //   'owner_name': nameController.text,
                  //   'owner_email': emailController.text,
                  //   'owner_mobile_number': mobileController.text,
                  //   'slot_address': addController.text,
                  //   'slot_pincode': pinController.text,
                  //   'total_slot': slotController.text,
                  //   'date': '26/11/2002',
                  //   'team_member_name': tnController.text,
                  //   'tid': tidController.text
                  //
                  //   // 'owner_name': oname,
                  //   // 'owner_email': email,
                  //   // 'owner_mobile_number': onumber,
                  //   // 'slot_address': address,
                  //   // 'slot_pincode': pin,
                  //   // 'total_slot': nslot,
                  //   // 'date': '26/11/2002',
                  //   // 'team_member_name': tname,
                  //   // 'tid': tid
                  // }).then((value) => print('User Added'));

                  // AuthController.instance.addNewSlot(
                  //     emailController.text.trim(),
                  //     nameController.text.trim(),
                  //     pinController.text.trim(),
                  //     addController.text.trim(),
                  //     mobileController.text.trim(),
                  //     tidController.text.trim(),
                  // tnController.text.trim(),
                  // slotController.text.trim(),
                  // Controller.text.trim(),
                  // dob
                  // );
                },
                child: Container(
                    width: w * 0.5,
                    height: h * 0.08,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                            image: AssetImage("img/g.jpg"), fit: BoxFit.cover)),
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                          // backgroundColor: Colors.green[600],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              // SizedBox(height: w*0.35),
              // RichText(text: TextSpan(
              //     text: "Don\`t Have an Account? ",
              //     style: TextStyle(
              //         color: Colors.green[600],
              //         fontSize: 20
              //     ),
              //     children: [
              //       TextSpan(
              //           text: "Create",
              //           style: TextStyle(
              //               color: Colors.green[700],
              //               fontSize: 20,
              //               fontWeight: FontWeight.bold
              //           )
              //       )
              //     ]
              // ))
            ],
          ),
        ));
  }
  
  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Slot Added'),
        action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
