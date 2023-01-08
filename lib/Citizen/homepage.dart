import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String email = "Email Loading...";
  String Name = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  String? mtoken = " ";

  getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print("My Token is $mtoken");
      });
      saveToken(token!);
    });
  }

  void saveToken(String token) async {
    User? user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .update({"token": token});
  }

  void getUserFromDBUser() async {
    //return FirebaseFirestore.instance.collection('users').doc(userId).get();

    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: auth.currentUser!.email.toString())
        .get();

    for (var doc in querySnapshot.docs) {
      // Getting data directly
      Name = doc.get('fname');
      // Lname = doc.get('lnmae');
    }
    setState(() {});
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else {
      print("User declined or has not granted permission");
    }
  }

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(".............onMessage............");
      print(
          "onMessage : ${message.notification?.title}/${message.notification?.body}}");

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'Greener',
        'greeners',
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecifics,
          payload: message.data['body']);
    });
  }

  void initState() {
    requestPermission();
    initInfo();
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUserFromDBUser();
    var countTree = 98753;
    var o2 = 20.98;
    var co2 = 0.04;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: Scaffold(
        backgroundColor: Colors.green[200],
        appBar: AppBar(
          title: Text("Greener Citizen"),
          backgroundColor: Colors.green,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.notifications),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Notifications(
                          // payload: 'Notification',
                          ),
                    ))
              },
            ),
          ],
          /*actions: [
            Tooltip(
                message: 'Notification',
                child: IconButton(
                    onPressed: () => {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Notifications(),
                    ));
                    }, icon: Icon(Icons.notifications)))
          ],*/
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
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
                  height: 50,
                  width: width * 0.96,
                  child: Center(
                      child: Text(
                    "Hey, Welcome $Name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ))),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                  height: 180,
                  width: width - 16,
                  child: Row(
                    children: [
                      Container(
                        child:
                            Image(image: AssetImage("img/tree_PNG104381.png")),
                        width: 150,
                        height: 150,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          Text(
                            "$countTree",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Total Planted Trees",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // color: Colors.green,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                        height: 100,
                        width: 220,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '20.95%',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Oxygen in Air',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        // color: Colors.green,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                        height: 100,
                        width: 220,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '0.04%',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Carbon Dioxide in Air',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        // color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                  height: height * 0.35,
                  width: width - 16,
                  child: Stack(
                    children: <Widget>[
                      GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target:
                                  LatLng(8.85577417427599, 38.81151398296511),
                              zoom: 15))
                    ],
                  ),
                  // color: Colors.green,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Our Sponsore',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.green[900]),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Sponsor(
                        "Google",
                        "https://play-lh.googleusercontent.com/6UgEjh8Xuts4nwdWzTnWH8QtLuHqRMUB7dp24JYVE2xcYzq4HA8hFfcAbU-R-PC_9uA1",
                        context),
                    Sponsor(
                        "Microsoft",
                        "https://play-lh.googleusercontent.com/kHRf85euDvW-Kg7ThXK2vv-J-Yye9uxoo6GQvUcAwudNRz1sQvXubAl_m2bu6KJofA",
                        context),
                    Sponsor(
                        "Samsung",
                        "https://new-media.dhakatribune.com/en/uploads/2022/05/17/samsung-logo.jpeg",
                        context),
                    Sponsor(
                        "Apple",
                        "https://beebom.com/wp-content/uploads/2021/08/How-to-Type-Apple-Logo-on-iPhone-iPad-and-Mac-1-e1629868886428.jpg?w=750&quality=75",
                        context),
                  ],
                ),
              ),
            ],
          ),
          // child: Container(
          //
          //   child: Column(
          //     children: <Widget>[
          //       Expanded(
          //         flex: 4,
          //           child: Container(
          //             margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(5),
          //               color: Colors.green[300],
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black12.withOpacity(0.5),
          //                   spreadRadius: 5,
          //                   blurRadius: 7,
          //                   offset: Offset(0, 0),
          //                 ),
          //               ],
          //             ),
          //             height: height * 0.25,
          //             width: width * 0.9,
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: <Widget>[
          //                 SizedBox(
          //                   child: Center(
          //                     child: Text(
          //                       '$countTree',
          //                       style: TextStyle(
          //                         fontSize: 40,
          //                         color: Colors.white,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   child: Center(
          //                     child: Text(
          //                       'Total Tree\'s Planted',
          //                       style: TextStyle(
          //                         fontSize: 25,
          //                         color: Colors.white,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //       ),
          //       Expanded(
          //         flex: 4,
          //         child: Row(
          //           children: <Widget>[
          //             Expanded(
          //               flex: 5,
          //               child: Container(
          //                 margin: const EdgeInsets.only(left: 20, right: 10),
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(5),
          //                   color: Colors.green[300],
          //                   boxShadow: [
          //                     BoxShadow(
          //                       color: Colors.black12.withOpacity(0.5),
          //                       spreadRadius: 5,
          //                       blurRadius: 7,
          //
          //                       offset: Offset(0, 0),
          //                     ),
          //                   ],
          //                 ),
          //                 height: height * 0.20,
          //                 width: width * 0.9,
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: <Widget>[
          //                     SizedBox(
          //                       child: Center(
          //                         child: Text(
          //                           '$o2% O2',
          //                           style: TextStyle(
          //                             fontSize: 30,
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                     SizedBox(
          //                       child: Center(
          //                         child: Text(
          //                           'Produce',
          //                           style: TextStyle(
          //                             fontSize: 25,
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             Expanded(
          //               flex: 5,
          //               child: Container(
          //                 margin: const EdgeInsets.only(left: 10, right: 20),
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(5),
          //                   color: Colors.green[300],
          //                   boxShadow: [
          //                     BoxShadow(
          //                       color: Colors.black12.withOpacity(0.5),
          //                       spreadRadius: 5,
          //                       blurRadius: 7,
          //                       offset: Offset(0, 0),
          //                     ),
          //                   ],
          //                 ),
          //                 height: height * 0.20,
          //                 width: width * 0.9,
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: <Widget>[
          //                     SizedBox(
          //                       child: Center(
          //                         child: Text(
          //                           '$co2% CO2',
          //                           style: TextStyle(
          //                             fontSize: 30,
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                     SizedBox(
          //                       child: Center(
          //                         child: Text(
          //                           'Reduce',
          //                           style: TextStyle(
          //                             fontSize: 25,
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //       Expanded(
          //         flex: 4,
          //         child: Container(
          //           // color: Colors.tealAccent,
          //           alignment: Alignment.center,
          //           // child: Text("#8d4383"),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}

Widget Sponsor(String name, String img, BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return Padding(
    padding: const EdgeInsets.all(8.0),
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
      height: 133,
      width: 120,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Image border
              child: SizedBox.fromSize(
                size: Size.fromRadius(40), // Image radius
                child: Image.network(img, fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "$name",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
      // color: Colors.green,
    ),
  );
}

// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   var i = 3;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Greener'),
//         backgroundColor: Colors.green,
//       ),
//       body: StaggeredGridView.countBuilder(
//           crossAxisCount: 2,
//           mainAxisSpacing: 20,
//           padding: EdgeInsets.only(left: 20, right: 20),
//           crossAxisSpacing: 20,
//           itemBuilder: (c, i){
//             return Container(
//               color: i % 2 == 0 ? Colors.black : Colors.deepOrange,
//               child: Center(
//                 child: Text(
//                   '1234',
//                   style: TextStyle(
//                     fontSize: 30,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             );
//           },
//           staggeredTileBuilder: (index){
//             return StaggeredTile.count(2, 1);
//           }),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// // import 'package:google_nav_bar/google_nav_bar.dart';
//
// class HomePage extends StatelessWidget {
//   // const Citizen_Home3({Key? key}) : super(key: key);
//   var treeCount = 47928;
//   Widget _selectedCleaning({
//     required Color color,
//     required String tittle,
//     required String subtittle
//   }){
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10.0),
//       padding: EdgeInsets.only(left: 20),
//       height: 125,
//       width: 240,
//       decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(15.0)
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             tittle,style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text(
//             subtittle,
//             style: TextStyle(
//               fontSize: 19,
//               color: Colors.white70,
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _selectedExtras({required String image, required String name}){
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           border: Border.all(color: Colors.grey, width: 2)
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height: 60,
//             decoration: BoxDecoration(
//                 image: DecorationImage(image: AssetImage(image))
//             ),
//           ),
//           SizedBox(height: 10,),
//           Text(name, style: TextStyle(fontSize: 17),)
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.green,
//         title: Text(
//           "Greener",
//           style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         child: Container(
//           height: 800,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             // borderRadius: BorderRadius.only(
//             //   topLeft: Radius.circular(20),
//             //   topRight: Radius.circular(20)
//             // ),
//           ),
//           child: ListView(
//
//             children: [
//               // Padding(
//               //   padding: EdgeInsets.only(top: 30, left: 30),
//               //   child: Text(
//               //     "Benefits",
//               //     style: TextStyle(
//               //       fontSize: 19,
//               //       color: Colors.black87,
//               //       fontWeight: FontWeight.w500,
//               //     ),
//               //   ),
//               // ),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                     left: 30,
//                     top: 30,
//                   ),
//                   child: Row(
//                     children: [
//                       _selectedCleaning(
//                           color: Colors.green,
//                           subtittle: "Total Tree's Planted",
//                           tittle: '$treeCount'
//                       ),
//                       _selectedCleaning(
//                           color: Colors.green,
//                           subtittle: "Produce",
//                           tittle: 'XX.XX% O2'
//                       ),
//                       _selectedCleaning(
//                           color: Colors.green,
//                           subtittle: "Reduce",
//                           tittle: 'XX.XX% CO2'
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 30,
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Selected Extras',
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                         top: 20,
//                       ),
//                       child: Container(
//                         height: 300,
//                         child: GridView.count(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 12,
//                           mainAxisSpacing: 8,
//                           childAspectRatio: 1.30,
//                           children: [
//                             _selectedExtras(
//                               image: 'img/g.jpg',
//                               name: 'AMC Team',
//                             ),
//                             _selectedExtras(
//                               image: 'img/g.jpg',
//                               name: 'Organization',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       // bottomNavigationBar: GNav(
//       //     backgroundColor: Colors.green,
//       //     color: Colors.white,
//       //     activeColor: Colors.green,
//       //     tabBackgroundColor: Colors.grey.shade800,
//       //     gap: 4,
//       //     padding: EdgeInsets.all(16),
//       //     tabs: const [
//       //       GButton(
//       //         icon: Icons.home,
//       //       ),
//       //       GButton(
//       //         icon: Icons.park,
//       //       ),
//       //       GButton(
//       //         icon: Icons.qr_code_2,
//       //       ),
//       //       GButton(
//       //         icon: Icons.yard_outlined,
//       //       ),
//       //       GButton(
//       //         icon: Icons.account_circle_rounded,
//       //       ),
//       //     ]),
//     );
//   }
// }
