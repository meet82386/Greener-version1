import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'hamburger.dart';
import 'profile_info.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}




class _ChangePassState extends State<ChangePass> {
  bool login = false;

  var email = TextEditingController();
  var password = TextEditingController();

  var displayName = TextEditingController();

  var currentPass = TextEditingController();
  var newPass = TextEditingController();
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          login = true;
        });
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.green[200],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Change Password'),
          backgroundColor: Colors.green,
        ),
        body: Center(
        child:
        // login ?
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // const Text('Home Page'),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(FirebaseAuth.instance.currentUser!.email!, style: TextStyle(fontSize: 18),),
              ),
              // Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: Text(
              //       FirebaseAuth.instance.currentUser!.displayName ??
              //       'No Name'),
              // ),
              // Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: TextFormField(
              //     controller: displayName,
              //     decoration: InputDecoration(
              //     hintText: FirebaseAuth
              //         .instance.currentUser!.displayName ??
              //     'Name'),
              //     ),
              // ),
              SizedBox(height: 10,),
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
                  child: TextFormField(
                  obscureText: true,
                  controller: currentPass,
                  decoration: InputDecoration(
                      hintText: "Enter The Current Password",
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
              SizedBox(height: 20,),
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
                child: TextFormField(
                obscureText: true,
                controller: newPass,
                decoration: InputDecoration(
                    hintText: "Enter The New Password",
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
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                  onTap: () async {
                    if (displayName.value.text.isNotEmpty) {
                    try {
                    FirebaseAuth.instance.currentUser!
                        .updateDisplayName(displayName.text);
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePass()));
                    } catch (e) {
                    if (kDebugMode) {
                    print(e);
                    }
                    }
                    }
                    if (currentPass.value.text.isNotEmpty &&
                        newPass.value.text.isNotEmpty) {
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                        email: FirebaseAuth
                            .instance.currentUser!.email!,
                        password: currentPass.text);
                        await FirebaseAuth.instance.currentUser!
                            .updatePassword(newPass.text);
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                          content: Text('Update Success')));
                    }
                  },
                  child: Container(
                      width: w * 0.5,
                      height: h * 0.08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage("img/g.jpg"), fit: BoxFit.cover)),
                      child: Center(
                        child: Text(
                          "Update",
                          style: TextStyle(
                            // backgroundColor: Colors.green[600],
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )),),
              ),
    //           Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: ElevatedButton(
    //               onPressed: () async {
    //               await FirebaseAuth.instance.signOut();
    //               setState(() {});
    //               login = false;
    //               },
    //               child: const Text('Sign out')),
    //           )
    //       ],
    //       ),
    //       )
    //     : Padding(
    //           padding: const EdgeInsets.all(16.0),
    //           child: Column(
    //           children: [
    //           const Padding(
    //           padding: EdgeInsets.all(8.0),
    //           child: Text('Login'),
    //           ),
    //             TextField(
    //             controller: email,
    //             decoration: const InputDecoration(labelText: 'Email'),
    //             ),
    //             TextField(
    //             obscureText: true,
    //             controller: password,
    //             decoration: const InputDecoration(labelText: 'Password'),
    //             ),
    //           Padding(
    //             padding: const EdgeInsets.all(16.0),
    //             child: ElevatedButton(
    //             onPressed: () async {
    //             try {
    //             final userCredential = await FirebaseAuth.instance
    //                 .signInWithEmailAndPassword(
    //             email: email.text,
    //             password: password.text);
    //             final user = userCredential.user;
    //             if (kDebugMode) {
    //             print(user?.uid);
    //             }
    //             setState(() {});
    //             login = true;
    //             } catch (e) {
    //               ScaffoldMessenger.of(context).showSnackBar(
    //               SnackBar(content: Text(e.toString())));
    //             }
    //             },
    //                 child: const Text('Login')),
    // )
              ],
            ),
          ),
        ),
    );
  }
}
