import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @author jd

class SportsTabHomeVM extends ChangeNotifier {
  Color appBarBackgroundColor = Colors.blue;

  void changAppBarBackgroundColor(Color color) {
    appBarBackgroundColor = color;
    notifyListeners();
  }
}
