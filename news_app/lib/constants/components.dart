import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );
void navigateToReplacement(context, Widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );
void showToast({
  required String text,
  required Color color,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 8,
      backgroundColor: Colors.white,
      textColor: color,
      fontSize: 16.0,
    );