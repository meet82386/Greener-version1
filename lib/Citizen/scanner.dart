import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Scanner extends StatelessWidget {
  const Scanner({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

final CollectionReference users = FirebaseFirestore.instance.collection('scanner');

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

var getResult = 'QR Code Result';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
              'Scanner'
            ),
            actions: [
            Tooltip(
                message: 'Scanner',
                child: IconButton(
                    onPressed: () => {scanQRCode()}, icon: Icon(Icons.qr_code_scanner)))
          ],
          ),
          backgroundColor: Colors.green[200],
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0,),
            Text(getResult, style: TextStyle(color: Colors.white, fontSize: 10),),
                  const Divider(
                    height: 20,
                    thickness: 4,
                    indent: 20,
                    endIndent: 20,
                    color: Colors.black54,
                  ),
                  getDetails(getResult),
                          ],
          )
    );
  }

void scanQRCode() async {
    try{
      final qrCode = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });
    print("QRCode_Result:--");
      print(qrCode);
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
  }

  }


  Widget getDetails(String did){
    return FutureBuilder(
        future: users.doc(did).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasError){
            return Text("Something went Wrong");
          }
          if(snapshot.hasData && !snapshot.data!.exists){
            return Text("Document does not exist");
          }
          if(snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            // return Text("Tree Name: ${data['Tree_Name']} ${data['Celebration']}");
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                      child: Container(
                        width: 250,
                        height: 250,
                        // margin: EdgeInsets.only(
                        //   top: 30,
                        // ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(data['Image_Url']),
                              fit: BoxFit.fill
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text("Tree Name: ${data['Tree_Name']}", style: TextStyle(fontSize: 20, color: Colors.black), maxLines: 2,),
                    SizedBox(height: 8,),
                    Text("Celebration: ${data['Celebration']}", style: TextStyle(fontSize: 20, color: Colors.black), maxLines: 2,),
                    SizedBox(height: 8,),
                    Text("About Celebration: ${data['About_Celebration']}", style: TextStyle(fontSize: 20, color: Colors.black), maxLines: 10,),
                  ],
              ),
              ),
            );
          }
          return Text("loading");
        }
    );
  }
}
