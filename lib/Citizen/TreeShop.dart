import 'package:flutter/material.dart';

class TreeShop extends StatefulWidget {
  @override
  _TreeShopState createState() => _TreeShopState();
}

class _TreeShopState extends State<TreeShop> {
  final items = ["Amroli", "Mota varachha", "Yogichowk", "Katargam"];
  String? value;

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          title: Text('Greener'),
          backgroundColor: Colors.green,
        ),
        body: ListView(children: [
          Container(
            height: 800,
            margin: EdgeInsets.only(top: 13, left: 10, right: 10),
            child: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                children: [
                  Text(
                    'Select your region :',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DropdownButton<String>(
                      value: value,
                      dropdownColor: Colors.green,
                      iconSize: 35,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.green),
                      isExpanded: true,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() => this.value = value),
                    ),
                  ),
                  SizedBox(
                    height: 400,
                  ),
                  Text(
                    'Contact AMC Team :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '1234567890 , 1234567890',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35))),
          ),
        ]));
  }
}
