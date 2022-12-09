import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greener_v1/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'hamburger.dart';

class Profile_Settings extends StatefulWidget {
  const Profile_Settings({Key? key}) : super(key: key);

  @override
  State<Profile_Settings> createState() => _Profile_SettingsState();
}

class _Profile_SettingsState extends State<Profile_Settings> {
  FirebaseAuth auth = FirebaseAuth.instance;
  void getUserFromDBUser() async {
    //return FirebaseFirestore.instance.collection('users').doc(userId).get();
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: auth.currentUser!.email.toString())
        .get();

    for (var doc in querySnapshot.docs) {
      // Getting data directly
      fnameController.text = doc.get('fname');
      lnameController.text = doc.get('lname');
      mobileController.text = doc.get('mobile').toString();
      dobController.text = doc.get('birthDate');
      marriageController.text = doc.get('marriageDate');
    }

    setState(() {});
  }

  // void getData() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   var vari = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user?.uid)
  //       .get();
  //   setState(() {
  //     fname = vari.data()!['fname'];
  //     lname = vari.data()!['lname'];
  //     mobile = vari.data()!['mobile'];
  //     birthDate = vari.data()!['birthDate'];
  //     Email = vari.data()!['email'];
  //   });
  // }

  @override
  void initState() {
    getUserFromDBUser();
    super.initState();
  }

  // void writeNewPost(
  //     String email, String fname, String lname, int mobile) async {
  //   // A post entry.
  //   final postData = {
  //     'email': email,
  //     'fname': fname,
  //     'lname': lname,
  //     'mobile': mobile,
  //   };
  //
  //   // Get a key for a new Post.
  //   final newPostKey =
  //       FirebaseDatabase.instance.ref().child('posts').push().key;
  //
  //   // Write the new post's data simultaneously in the posts list and the
  //   // user's post list.
  //   final Map<String, Map> updates = {};
  //   updates['/user/$newPostKey'] = postData;
  //
  //   return FirebaseDatabase.instance.ref().update(updates);
  // }

  // final Stream<QuerySnapshot> citizenStream =
  //     FirebaseFirestore.instance.collection('users').snapshots();
  // String? get email => '';
  // String? get password => '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController marriageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: Text('Edit Profile'),
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
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "Sign up for Citizen",
                  //   style: TextStyle(
                  //       fontSize: 25,
                  //       color: Colors.green[600],
                  //       fontWeight: FontWeight.bold),
                  // ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  Row(
                    children: [
                      Text(
                        "First Name:",
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
                      controller: fnameController,
                      decoration: InputDecoration(
                          hintText: "Firstname",
                          // prefixIcon: Icon(Icons.nam, color:Colors.green),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
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
                        "Last Name:",
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
                      controller: lnameController,
                      decoration: InputDecoration(
                          // prefixIcon: Icon(Icons.email, color:Colors.green),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
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
                        "Mobile Number:",
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
                      controller: mobileController,
                      decoration: InputDecoration(
                          prefixText: "+91  ",
                          // prefixIcon: Icon(Icons.email, color:Colors.green),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
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
                        "Birth Date:",
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
                      controller: dobController,
                      decoration: InputDecoration(
                          // prefixIcon: Icon(Icons.email, color:Colors.green),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
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
                        "Marriage Date:",
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
                      controller: marriageController,
                      decoration: InputDecoration(
                          hintText: "dd/mm/yyyy",
                          // prefixIcon: Icon(Icons.email, color:Colors.green),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
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
                  //       SizedBox(
                  //         height: 20,
                  //       ),
                  //       Row(
                  //         children: [
                  //           AnimatedContainer(
                  //             duration: Duration(milliseconds: 500),
                  //             width: 20,
                  //             height: 20,
                  //             decoration: BoxDecoration(
                  //                 color: _isPasswordEightCharacters
                  //                     ? Colors.green
                  //                     : Colors.transparent,
                  //                 border: _isPasswordEightCharacters
                  //                     ? Border.all(color: Colors.transparent)
                  //                     : Border.all(color: Colors.grey.shade400),
                  //                 borderRadius: BorderRadius.circular(50)),
                  //             child: Center(
                  //               child: Icon(
                  //                 Icons.check,
                  //                 color: Colors.white,
                  //                 size: 15,
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 10,
                  //           ),
                  //           Text("Contains at least 8 characters")
                  //         ],
                  //       ),
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //       Row(
                  //         children: [
                  //           AnimatedContainer(
                  //             duration: Duration(milliseconds: 500),
                  //             width: 20,
                  //             height: 20,
                  //             decoration: BoxDecoration(
                  //                 color: _hasPasswordOneNumber
                  //                     ? Colors.green
                  //                     : Colors.transparent,
                  //                 border: _hasPasswordOneNumber
                  //                     ? Border.all(color: Colors.transparent)
                  //                     : Border.all(color: Colors.grey.shade400),
                  //                 borderRadius: BorderRadius.circular(50)),
                  //             child: Center(
                  //               child: Icon(
                  //                 Icons.check,
                  //                 color: Colors.white,
                  //                 size: 15,
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 10,
                  //           ),
                  //           Text("Contains at least 1 number")
                  //         ],
                  //       ),
                  //       // SizedBox(height: 15,),
                  //       // Row(
                  //       //   children: [
                  //       //     Expanded(child: Container(),),
                  //       //     Text(
                  //       //       "Forgot Your Password?",
                  //       //       style: TextStyle(
                  //       //           fontSize: 18,
                  //       //           color: Colors.grey[600]
                  //       //       ),
                  //       //     ),
                  //       //   ],
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      User? user = FirebaseAuth.instance.currentUser;
                      var vars = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user?.uid)
                          .update({
                        "fname": fnameController.text,
                        "lname": lnameController.text,
                        "mobile": mobileController.text,
                        "birthDate": dobController.text,
                        "marriageDate": marriageController.text,
                      });
                    },
                    child: Center(
                      child: Container(
                          width: w * 0.5,
                          height: h * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                  image: AssetImage("img/g.jpg"),
                                  fit: BoxFit.cover)),
                          child: Center(
                            child: Text(
                              "Save Change",
                              style: TextStyle(
                                // backgroundColor: Colors.green[600],
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ),
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
            )
          ],
        ),
      ),
    );
  }
}
