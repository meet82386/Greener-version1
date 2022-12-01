// import 'package:appbar_example/main.dart';
import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class AMC_Home extends StatefulWidget {
  @override
  _AMC_HomeState createState() => _AMC_HomeState();
}

class _AMC_HomeState extends State<AMC_Home> {
  Query dbRef = FirebaseDatabase.instance.ref().child('AskToPlant');

  // DatabaseReference reference =
  //     FirebaseDatabase.instance.ref().child('AskToPlant');

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.green[200],
        appBar: AppBar(
          title: Text("AMC Team"),
          actions: [
            Tooltip(
              message: 'Log Out',
              child: IconButton(
                  onPressed: () {
                    AuthController.instance.logout();
                  },
                  icon: Icon(Icons.logout)),
            )
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.lightGreen],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
          bottom: TabBar(
            //isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(icon: Icon(Icons.free_cancellation), text: 'Free'),
              Tab(icon: Icon(Icons.workspace_premium), text: 'Premium'),
            ],
          ),
          elevation: 20,
          titleSpacing: 20,
        ),
        // body: Container(
        //   color: Colors.green[200],
        //   height: double.infinity,
        //   child: FirebaseAnimatedList(
        //     query: dbRef,
        //     itemBuilder: (BuildContext context, DataSnapshot snapshot,
        //         Animation<double> animation, int index) {
        //       Map qu = snapshot.value as Map;
        //       qu['key'] = snapshot.key;
        //
        //       return Free(query1: qu);
        //     },
        //   ),
        // ),
        // body: buildPagefree('Free'),
        body: TabBarView(
          children: [
            Scaffold(
              body: Container(
                color: Colors.green[200],
                height: double.infinity,
                child: FirebaseAnimatedList(
                  query: dbRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map qu = snapshot.value as Map;
                    qu['key'] = snapshot.key;

                    return (qu['plan'] == 'Free') ? Free(query1: qu) : null_w();
                  },
                ),
              ),
            ),
            Scaffold(
              body: Container(
                color: Colors.green[200],
                height: double.infinity,
                child: FirebaseAnimatedList(
                  query: dbRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map qu = snapshot.value as Map;
                    qu['key'] = snapshot.key;
                    return (qu['plan'] == 'Subscription')
                        ? Premium(query1: qu)
                        : null_w();
                    return Premium(query1: qu);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget null_w() {
    return SizedBox.shrink();
  }

  Widget Free({required Map query1}) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      height: 230,
      width: w * 98,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.green[300],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "  Name : " + query1['Name'],
            style: TextStyle(color: Colors.white, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "  Tree Name : pipal ",
            style: TextStyle(color: Colors.white, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
          // Text(
          //   "  Leader Contact No.: $pno ",
          //   style: TextStyle(color: Colors.white, fontSize: 20),
          //   overflow: TextOverflow.ellipsis,
          // ),
          // Text(
          //   "  Area Pincode: 395010 ",
          //   style: TextStyle(color: Colors.white, fontSize: 20),
          //   overflow: TextOverflow.ellipsis,
          // ),
          Text(
            "  Place Name :  " + query1['PlaceName'],
            style: TextStyle(color: Colors.white, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "  Email :  " + query1['email'],
            style: TextStyle(color: Colors.white, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "  Mobile Number :  " + query1['mobile_number'],
            style: TextStyle(color: Colors.white, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "  Time Slot :   " + query1['time_slot'],
            style: TextStyle(color: Colors.white, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {},
                icon: Icon(
                  // <-- Icon
                  Icons.done,
                  size: 24.0,
                ),
                label: Text('Accept'), // <-- Text
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {},
                icon: Icon(
                  // <-- Icon
                  Icons.close,
                  size: 24.0,
                ),
                label: Text('Reject'), // <-- Text
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget Premium({required Map query1}) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      height: 200,
      width: w * 98,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.green[300],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "  Name : " + query1['Name'],
            style: TextStyle(color: Colors.white, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "  Tree Name : Menduvada ",
            style: TextStyle(color: Colors.white, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
          // Text(
          //   "  Leader Contact No.: pno ",
          //   style: TextStyle(color: Colors.white, fontSize: 20),
          //   overflow: TextOverflow.ellipsis,
          // ),
          // Text(
          //   "  Area Pincode: in ",
          //   style: TextStyle(color: Colors.white, fontSize: 20),
          //   overflow: TextOverflow.ellipsis,
          // ),
          Text(
            "  Place Name : " + query1['PlaceName'],
            style: TextStyle(color: Colors.white, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "  Date : " + query1['PlaceName'],
            style: TextStyle(color: Colors.white, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "  Time : " + query1['time_slot'],
            style: TextStyle(color: Colors.white, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {},
                icon: Icon(
                  // <-- Icon
                  Icons.done,
                  size: 24.0,
                ),
                label: Text('Accept'), // <-- Text
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {},
                icon: Icon(
                  // <-- Icon
                  Icons.close,
                  size: 24.0,
                ),
                label: Text('Reject'), // <-- Text
              ),
            ],
          ),
        ],
      ),
    );
  }
}
