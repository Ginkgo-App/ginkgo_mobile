import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SampleCreen extends StatefulWidget {
  @override
  _SampleCreenState createState() => _SampleCreenState();
}

class _SampleCreenState extends State<SampleCreen> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample Screen'),
        leading: FlatButton(
          onPressed: () {Navigator.pop(context);},
          child: Icon(Icons.arrow_back),)
      ),
      body: Center(child: Text('bạn đã nhấn button $_count lần.')),
      backgroundColor: Colors.blueGrey.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _count++),
        tooltip: 'đếm tăng dần',
        child: Icon(Icons.add),
      ),
    );
  }
}
