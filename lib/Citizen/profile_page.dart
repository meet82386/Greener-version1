import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import '../users.dart';
import 'user_preferences.dart';
import 'appbar_widget.dart';
import '../button_widget.dart';
import 'numbers_widget.dart';
import 'profile_widget.dart';
import '../controllers/auth_controller.dart';
import './hamburger.dart';
import 'image_pick.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ImagePicker picker = ImagePicker();
  XFile? file;
  String imageUrl = '';
  String fname = "a";
  String lname = "a";
  String email = "a";
  String birthDate = "a";
  String role = "a";
  var mno;

  void getData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get();
    setState(() {
      fname = vari.data()!['fname'];
      lname = vari.data()!['lname'];
      email = vari.data()!['email'];
      imageUrl = vari.data()!['profile-image'];
      birthDate = vari.data()!['birthDate'];
      role = vari.data()!['role'];
      mno = vari.data()!['mobile'].toString();
    });
  }

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    getData();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Greener",
        ),
      ),

      drawer: HamBurger(),

      //body
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Colors.green[200],
              child: Center(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 150,
                            width: 150,
                            color: Colors.black12,
                            child: imageUrl == ''
                                ? Icon(
                                    Icons.image,
                                    size: 40,
                                  )
                                : Scaffold(
                                    body: Image.network(imageUrl),
                                  )),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                ),
                              ],
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: InkWell(
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.white,
                              ),
                              onTap: () async {
                                ImagePicker imagePicker = ImagePicker();
                                file = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                print('${file?.path}');
                                setState(() {});
                                if (file == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Please upload an image')));

                                  return;
                                }

                                String uniqueFileName = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                Reference referenceRoot =
                                    FirebaseStorage.instance.ref();
                                FirebaseAuth auth = FirebaseAuth.instance;
                                String? mail = auth.currentUser!.email;
                                // String? fname = auth.currentUser!.fname;
                                Reference referenceDirImages =
                                    referenceRoot.child(mail.toString());

                                Reference referenceImageToUpload =
                                    referenceDirImages.child(uniqueFileName);
                                try {
                                  //Store the file
                                  await referenceImageToUpload
                                      .putFile(File(file!.path));
                                  //Success: get the download URL
                                  imageUrl = await referenceImageToUpload
                                      .getDownloadURL();
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(auth.currentUser!.uid)
                                      .update({'profile-image': imageUrl});
                                  setState(() {});
                                } catch (error) {
                                  print("Some error occured");
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "$fname $lname",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            thickness: 3,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            // width: 280,
                            // height: 50,
                            // margin: EdgeInsets.only(right: 40),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.email,
                                      color: Colors.black54,
                                      size: 20,
                                    ),
                                    Text(
                                      ' E-mail ID: $email',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.phone,
                                      color: Colors.black54,
                                      size: 20,
                                    ),
                                    Text(
                                      ' Mobile Number: $mno',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.calendar_month,
                                      color: Colors.black54,
                                      size: 20,
                                    ),
                                    // Text("  "),
                                    // Text("  "),
                                    Text(
                                      ' Birth Date: $birthDate',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.format_list_bulleted_rounded,
                                      color: Colors.black54,
                                      size: 20,
                                    ),
                                    Text(
                                      ' Role: $role',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
