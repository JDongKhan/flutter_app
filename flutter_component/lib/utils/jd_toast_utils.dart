
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class JDToast {
  static void showSnackBar(BuildContext context,  String msg, {
        Duration duration = const Duration(milliseconds: 600),
        SnackBarAction action
      }) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        duration: duration,
        action: action,
        backgroundColor: Theme.of(context).primaryColor,
      ));
  }

  static void toast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,  // 消息框弹出的位置
        // backgroundColor: Colors.grey,
        // textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

