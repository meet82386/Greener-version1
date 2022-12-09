import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:greener_v1/Citizen/bottomnav.dart';
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

class Get_QR_Code extends StatefulWidget {
  const Get_QR_Code({Key? key, required this.tid}) : super(key: key);
  final String tid;

  @override
  State<Get_QR_Code> createState() => _Get_QR_CodeState();
}

class _Get_QR_CodeState extends State<Get_QR_Code> {

  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('QR-Code'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.green[200],
        child: Column(
          children: [
            buildQR(),
            // ButtonWidget(text: 'Capture Screen', onClicked: () async{
            //   final image = await controller.capture();
            //   if(image == null)
            //     return;
            //   await saveImage(image);
            // }),
            SizedBox(height: h * 0.15,),
            // ButtonWidget(
            //     text: 'Download QR-Code',
            //     onClicked: () async{
            //       final image = await controller.captureFromWidget(buildQR());
            //       saveAndShare(image);
            //
            //       Fluttertoast.showToast(
            //           msg: "Download Done",
            //           toastLength: Toast.LENGTH_SHORT,
            //           gravity: ToastGravity.BOTTOM,
            //           timeInSecForIosWeb: 1,
            //           textColor: Colors.white,
            //           fontSize: 16.0
            //       );
            //
            //       // Navigator.pop(context, MaterialPageRoute(builder: (context) => Bottom_Nav()));
            //     }
            // ),
            GestureDetector(
              onTap: () async{
                final image = await controller.captureFromWidget(buildQR());
                saveAndShare(image);

                Fluttertoast.showToast(
                    msg: "Download Done",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0
                );

                // Navigator.pop(context, MaterialPageRoute(builder: (context) => Bottom_Nav()));
              },
              child: Container(
                  width: w * 0.68,
                  height: h * 0.08,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage("img/g.jpg"),
                          fit: BoxFit.cover)),
                  child: Center(
                    child: Text(
                      "Download QR-Code",
                      style: TextStyle(
                        // backgroundColor: Colors.green[600],
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future saveAndShare(Uint8List bytes) async{
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);
    final text = 'Shared From Greener';
    await Share.shareFiles([image.path], text: text);
    await [Permission.storage].request();
    final time = DateTime.now().toIso8601String().replaceAll('.', '-').replaceAll(':', '-');
    final name = 'Greener_QR-Code_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filePath'];
  }

  Future<String> saveImage(Uint8List bytes) async{
    await [Permission.storage].request();
    final time = DateTime.now().toIso8601String().replaceAll('.', '-').replaceAll(':', '-');
    final name = 'Greener_QR_Code_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filePath'];
  }

  Widget buildQR() => Stack(
    children: [
      AspectRatio(
        aspectRatio: 1,
        child: QrImage(
          data: "${widget.tid}",
          size: 200,
          backgroundColor: Colors.white,
          foregroundColor: Colors.green[700],
        ),
      ),
    ],
  );
}
