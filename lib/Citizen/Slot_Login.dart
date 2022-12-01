import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:greener_v1/Citizen/local_noti_service.dart';

import 'notification.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Slot_Login extends StatefulWidget {
  Slot_Login({Key? key, required this.area}) : super(key: key);
  final String area;

  @override
  State<Slot_Login> createState() => _Slot_LoginState();
}

class _Slot_LoginState extends State<Slot_Login> {
  late String place_name = "Mota Varachha", name, mno, dob;
  FirebaseAuth auth = FirebaseAuth.instance;
  List<String> items = [
    "9:00 To 10:00",
    "10:00 To 11:00",
    "4:00 To 5:00",
    "5:00 To 6:00"
  ];
  String? selectedItem = '9:00 To 10:00';
  var nameController = new TextEditingController();
  var mnoController = new TextEditingController();
  var dateController = new TextEditingController();
  late final LocalNotificationService service;
  late DatabaseReference dbRef;
  CollectionReference users =
      FirebaseFirestore.instance.collection('AskToPlant');

  @override
  void initState() {
    service = LocalNotificationService();
    service.initialize();
    listenToNotification();
    dbRef = FirebaseDatabase.instance.ref().child('AskToPlant');
    super.initState();
  }

  void toast(String s) {
    Fluttertoast.showToast(
        msg: s,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  List<String> plan = ["Free", "Subscription"];
  String? selectedPlan = 'Free';

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: Text("Slot Login"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "${widget.area}",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800),
              ),
              const Divider(
                height: 20,
                thickness: 4,
                indent: 20,
                endIndent: 20,
                color: Color(0xFF206F24),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Plans:",
                    style: TextStyle(fontSize: 20, color: Colors.green[600]),
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
                margin: EdgeInsets.only(top: 5, left: 3),
                child: SizedBox(
                    width: w * 0.99,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        // enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 3,color:Colors.green)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(30))),
                      ),
                      value: selectedPlan,
                      items: plan
                          .map((item) =>
                              DropdownMenuItem(value: item, child: Text(item)))
                          .toList(),
                      onChanged: (item) => setState(() => selectedPlan = item),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Name:",
                    style: TextStyle(fontSize: 20, color: Colors.green[600]),
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
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: "Enter Your First Name",
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
                    "Mobile Number:",
                    style: TextStyle(fontSize: 20, color: Colors.green[600]),
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
                  controller: mnoController,
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
                    "Date:",
                    style: TextStyle(fontSize: 20, color: Colors.green[600]),
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
                  controller: dateController,
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
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Time:",
                    style: TextStyle(fontSize: 20, color: Colors.green[600]),
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
                margin: EdgeInsets.only(top: 5, left: 3),
                child: SizedBox(
                    width: w * 0.99,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        // enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 3,color:Colors.green)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(30))),
                      ),
                      value: selectedItem,
                      items: items
                          .map((item) =>
                              DropdownMenuItem(value: item, child: Text(item)))
                          .toList(),
                      onChanged: (item) => setState(() => selectedItem = item),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () async {
                  await service.showNotificationWithPayload(
                      id: 0,
                      title: 'Notification Title',
                      body: 'Some body',
                      payload: 'payload navigation');
                  Map<String, String> Req_for_slot = {
                    'Name': nameController.text.trim(),
                    'PlaceName': place_name,
                    'email': auth.currentUser!.email.toString(),
                    'mobile_number': mnoController.text.trim(),
                    'date': dateController.text.trim(),
                    'time_slot': selectedItem.toString(),
                    'plan': selectedPlan.toString(),
                  };
                  if (Req_for_slot['Name'] != '') {
                    if (Req_for_slot['mobile_number']?.length == 10) {
                      if (Req_for_slot['date'] != '') {
                        dbRef.push().set(Req_for_slot);
                      } else {
                        toast('Invalid date.');
                      }
                    } else {
                      toast("Invalid mobile number.");
                    }
                  } else {
                    toast("Name can not be null.");
                  }
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
                        "Book Now",
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
      ),
    );
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => Notifications(payload: payload))));
    }
  }
}
