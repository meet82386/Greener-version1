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
    });
  }

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Greener",
        ),

        /*actions: [
          Tooltip(
              message: 'Log Out',
              child: IconButton(
                  onPressed: () {
                    AuthController.instance.logout();
                  },
                  icon: Icon(Icons.logout)))
        ],*/
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
                            height: 180,
                            width: 200,
                            color: Colors.black12,
                            child: imageUrl == ''
                                ? Icon(
                                    Icons.image,
                                    size: 40,
                                  )
                                : Scaffold(
                                    body: Image.network(imageUrl),
                                  )),
                        // Container(
                        //   width: 120,
                        //   height: 120,
                        //   margin: EdgeInsets.only(
                        //     top: 30,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     image: DecorationImage(
                        //         image: NetworkImage(imagePath),
                        //         fit: BoxFit.fill),
                        //   ),
                        // ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.green,
                            ),
                            child: InkWell(
                              child: Icon(
                                Icons.edit,
                                size: 20,
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
                            /*child: Column(
                            children: [
                              Icon(Icons.edit,
                              size: 28,)
                            ],
                          ),*/
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 20,
                      width: 100,
                      margin: EdgeInsets.only(right: 40, left: 60),
                      child: Row(
                        children: <Widget>[
                          Text(
                            fname,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(" "),
                          Text(
                            lname,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      email,
                      style: TextStyle(fontSize: 16),
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

/*Widget displayImage(){
    if(image == null) {
      return Text("No Image Selected");
    }else{
      return Image.file(image);
    }

  }*/

}

/*

      // buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          // Center(child: buildUpgradeButton()),
          // const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 24),
          // buildAbout(user),
          // const SizedBox(height: 24),
          planted_tree(user, 'Neem', '29/11/2022', 'Birthday'),
          planted_tree(user, 'Pipal', '15/12/2022', 'Marriage Anniversary'),
          planted_tree(user, 'Neem', '14/02/2023', 'Velentine Day'),
          // const SizedBox(height: 24),
          // Center(child: logout()),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.green[900]),
          )
        ],
      );

  // Widget buildUpgradeButton() => ButtonWidget(
  //       text: 'Upgrade To PRO',
  //       onClicked: () {},
  //     );

  Widget planted_tree(User user, String Tname, String date, String cele) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
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
        height: height * 0.12,
        child: Row(
          children: [
            SizedBox(
              width: 8,
            ),
            Container(
                width: 60,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://images.app.goo.gl/f1m9tXorJtjdhCFy6"),
                )),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tree Name : $Tname",
                    style: TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Plantation Date : $date",
                    style: TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Celebration : $cele",
                    style: TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget logout() => ButtonWidget(
        text: 'Log Out',
        onClicked: () {
          AuthController.instance.logout();
        },
      );
}
*/
