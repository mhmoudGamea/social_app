import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  static void show(
      {required String message,
      required Color backColor,
      Color color = Colors.white,
      double fontSize = 15}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: backColor,
      textColor: color,
      fontSize: fontSize,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
