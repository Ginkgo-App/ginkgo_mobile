import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SampleCreen extends StatefulWidget {
  final String string;

  const SampleCreen({Key key, this.string}) : super(key: key);
  @override
  _SampleCreenState createState() => _SampleCreenState();
}

class _SampleCreenState extends State<SampleCreen> {
  int _count = 0;

  String get string => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample Screen of ' + string),
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
