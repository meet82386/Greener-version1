import 'package:flutter/material.dart';

class Plant extends StatelessWidget {
  const Plant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade200,
      appBar: AppBar(
        title: Text('Greener'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          'Plantation',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
