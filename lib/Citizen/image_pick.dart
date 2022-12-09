import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';
import 'hamburger.dart';

class ImagePick extends StatefulWidget {
  @override
  _ImagePickState createState() => _ImagePickState();
}


class _ImagePickState extends State<ImagePick> {



  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
          title: Text("Image Picker"),
          backgroundColor: Colors.green[900]
      ),
      body: Container(
        padding: EdgeInsets.only(top:20, left:20, right:20),
        alignment: Alignment.topCenter,
        child: Column(
            children: [

              ElevatedButton(
                  onPressed: () async {
                  image = await picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    //update UI
              });
              },
                  child: Text("Pick Image")
              ),

        image == null?Container():
        Image.file(File(image!.path))

        ],),
      ),
    );
  }


}
