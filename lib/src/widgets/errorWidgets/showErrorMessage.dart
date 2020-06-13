import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showErrorMessage(String message) async {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black.withOpacity(0.7),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
