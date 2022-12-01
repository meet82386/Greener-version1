import 'package:flutter/material.dart';
import 'package:greener_v1/Citizen/Slot_Login.dart';

class Plantation extends StatefulWidget {
  const Plantation({Key? key}) : super(key: key);

  @override
  State<Plantation> createState() => _PlantationState();
}

class _PlantationState extends State<Plantation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: Text("Available Slot"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                children: [
                  _Slot('Mota Varachha', 20, 7),
                  _Slot('Nana Varachha', 20, 4),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Row(
                children: [
                  _Slot('Varachha', 43, 42),
                  _Slot('Yogichowk', 4, 0),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Row(
                children: [
                  _Slot('Bardoli', 20, 0),
                  _Slot('Amroli', 20, 4),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Row(
                children: [
                  _Slot('Katar Gam', 20, 0),
                  _Slot('Vesu', 25, 12),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Row(
                children: [
                  _Slot('Puna Gam', 10, 10),
                  _Slot('Mota Varachha', 32, 21),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _Slot(String add, int total_slot, int free_slot) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    int full_slot = total_slot - free_slot;
    var color = Colors.red.shade200;
    var bcolor = Colors.red;
    if (free_slot == 0) {
      color = Colors.red.shade200;
      bcolor = Colors.red;
    } else {
      color = Colors.green;
      bcolor = Colors.blue;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      margin: EdgeInsets.only(left: 10, top: 3.5, right: 2, bottom: 2.5),
      padding: EdgeInsets.only(top: 7, left: 2, right: 2, bottom: 3),
      height: 250,
      width: w * 0.46,
      // color: color,
      child: Column(
        children: [
          Text(
            "$add",
            style: TextStyle(fontSize: 18),
          ),
          const Divider(
            height: 20,
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          SizedBox(height: 15),
          Text(
            "Total Slot : $total_slot",
            style: TextStyle(fontSize: 17, color: Colors.yellow),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Free Slot : $free_slot",
            style: TextStyle(fontSize: 17, color: Colors.cyanAccent),
          ),
          SizedBox(
            height: 8,
          ),
          Text("Full Slot : $full_slot",
              style: TextStyle(
                fontSize: 17,
                color: Colors.red,
              )),
          Container(
              margin: EdgeInsets.only(left: 8, top: 25, right: 8, bottom: 5),
              child: (color == Colors.green)
                  ? ElevatedButton(
                      child: Text("Plant "),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Slot_Login(area: add)));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(bcolor)),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 7),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      height: 37,
                      width: 68,
                      child: Center(
                          child: Text(
                        "Close",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      )),
                    ))
        ],
      ),
    );
  }
}
