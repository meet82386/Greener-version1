import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:greener_v1/Citizen/Get_QR_Code.dart';
import 'package:greener_v1/button_widget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:io';

import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class SWT extends StatefulWidget {
  const SWT({Key? key}) : super(key: key);

  @override
  State<SWT> createState() => _SWTState();
}

class _SWTState extends State<SWT> {
  String location = 'Lat: ... , Long: ...';
  String Address = 'search';
  String imageUrl = '';
  var file;

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  String? uid = '';
  String Name = '';
  String Lname = '';
  String FullName = "";
  String mo = '';

  void getUserFromDBUser() async {
    //return FirebaseFirestore.instance.collection('users').doc(userId).get();
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: auth.currentUser!.email.toString())
        .get();

    for (var doc in querySnapshot.docs) {
      // Getting data directly
      uid = doc.id;
      Name = doc.get('fname');
      Lname = doc.get('lname');
      mo = doc.get('mobile').toString();
    }
    setState(() {});
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getFullName();
  }

  void getFullName() {
    getUserFromDBUser();
    setState(() {
      FullName = '$Name $Lname';
    });
  }

  final controller = ScreenshotController();

  late String tname, cele, about;

  CollectionReference users = FirebaseFirestore.instance.collection('scanner');
  FirebaseAuth auth = FirebaseAuth.instance;

  // String name = auth.currentUser!.fname.toString() + ' ' + auth.currentUser!.lname.toString();

  @override
  Widget build(BuildContext context) {
    getUserFromDBUser();
    getFullName();
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Screenshot(
      controller: controller,
      child: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Selfie With Tree"),
        ),
        body: Container(
          height: h,
          width: w,
          color: Colors.green[200],
          child: SingleChildScrollView(
            child: Container(
              color: Colors.green[200],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Tree Name:",
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
                        // controller: fnameController,
                        decoration: InputDecoration(
                            hintText: "Enter Your Tree Name",
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
                          "Celebration :",
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
                          cele = value;
                        },
                        // controller: fnameController,
                        decoration: InputDecoration(
                            hintText: "Type Celebration",
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
                          "About Celebration:",
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
                          about = value;
                        },
                        // controller: fnameController,
                        maxLines: 5,
                        decoration: InputDecoration(
                            hintText: "Write About Celebration",
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
                    // ElevatedButton(
                    //   onPressed: () async{
                    //     await users.add({
                    //       'Name': 'Nikunj Sonigara',
                    //       'Tree_Name': tname,
                    //       'Celebration': cele,
                    //       'About_Celebration': about,
                    //       'email': auth.currentUser!.email.toString(),
                    //     }).then((value) => print('Tree Added'));
                    //   },
                    //   child: Text(
                    //     uid.toString(),
                    //   )
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Row(
                      children: [
                        Text(
                          "Upload Your Selfie With Tree :",
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[600]),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 180,
                          width: 200,
                          color: Colors.black12,
                          child: file == null
                              ? Icon(
                                  Icons.image,
                                  size: 40,
                                )
                              : Image.file(
                                  File(file!.path),
                                  fit: BoxFit.fill,
                                ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              height: 50,
                              minWidth: 140,
                              onPressed: () async {
                                ImagePicker imagePicker = ImagePicker();
                                file = await imagePicker.pickImage(
                                    source: ImageSource.camera);
                                print('${file?.path}');
                                setState(() {});
                                if (file == null) return;
                              },
                              color: Colors.green,
                              child: Text(
                                "take Selfie",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MaterialButton(
                              height: 50,
                              minWidth: 140,
                              onPressed: () {
                                file = null;
                                setState(() {});
                              },
                              color: Colors.red[300],
                              child: Text(
                                "Remove Selfie",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     SizedBox(
                    //       width: 50,
                    //     ),
                    //     MaterialButton(
                    //       onPressed: () async {
                    //         ImagePicker imagePicker = ImagePicker();
                    //         file = await imagePicker.pickImage(
                    //             source: ImageSource.camera);
                    //         print('${file?.path}');
                    //         setState(() {});
                    //         if (file == null) return;
                    //       },
                    //       color: Colors.green,
                    //       child: Text(
                    //         "take Selfie",
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     ),
                    //     MaterialButton(
                    //       onPressed: () {
                    //         file = null;
                    //         setState(() {});
                    //       },
                    //       color: Colors.red[300],
                    //       child: Text(
                    //         "Remove Selfie",
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 50,
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Coordinates Points',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            location,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'ADDRESS',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('${Address}'),
                          MaterialButton(
                              onPressed: () async {
                                Position position =
                                    await _getGeoLocationPosition();
                                location =
                                    'Lat: ${position.latitude} , Long: ${position.longitude}';
                                GetAddressFromLatLong(position);
                                setState(() {});
                              },
                              color: Colors.green,
                              child: Text(
                                'Get Location',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // QrImage(
                    //   data: 'dhruv',
                    //   size: 200,
                    // ),
                    // buildQR(),
                    // // ButtonWidget(text: 'Capture Screen', onClicked: () async{
                    // //   final image = await controller.capture();
                    // //   if(image == null)
                    // //     return;
                    // //   await saveImage(image);
                    // // }),
                    // SizedBox(height: 16,),
                    // ButtonWidget(text: 'Download QR-Code', onClicked: () async{
                    //   final image = await controller.captureFromWidget(buildQR());
                    //   saveAndShare(image);
                    // }),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (file == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please upload an image')));

                          return;
                        }
                        if (Address == 'search') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please select location.')));
                          return;
                        }

                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();
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
                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(auth.currentUser!.uid)
                              .update({
                            'imageData': FieldValue.arrayUnion([
                              {
                                'selfie': {
                                  'image': imageUrl,
                                  'coordinates': location,
                                  'address': Address,
                                },
                              },
                            ]),
                          });

                          String datetime = DateTime.now().toString();
                          // String did = mo + datetime;

                          await users.doc(datetime).set({
                            'Name': FullName,
                            'Tree_Name': tname,
                            'Celebration': cele,
                            'About_Celebration': about,
                            'Image_Url': imageUrl,
                            'Coordinates': location,
                            'Address': Address,
                            'Email': auth.currentUser!.email.toString(),
                          }).then((value) => print('Tree Added'));

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Get_QR_Code(
                                        tid: datetime,
                                      )));
                        } catch (error) {
                          print("Some error occured");
                        }
                      },
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
                              "Get QR-Code",
                              style: TextStyle(
                                // backgroundColor: Colors.green[600],
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ),
                    // ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Get_QR_Code(tid: uid.toString(),)));}, child: Text('get QR'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);
    final text = 'Shared From Greener';
    await Share.shareFiles([image.path], text: text);
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'Greener_QR-Code_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filePath'];
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'Greener_QR_Code_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filePath'];
  }

  Widget buildQR() => Stack(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: QrImage(
              data: 'Nikunj Sonigara',
              size: 200,
              // backgroundColor: Colors.black,
              foregroundColor: Colors.green,
            ),
          ),
        ],
      );
}
