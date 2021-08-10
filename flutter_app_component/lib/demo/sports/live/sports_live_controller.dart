import 'package:flutter/cupertino.dart';

/// @author jd

class SportsLiveController extends ChangeNotifier {
  Orientation orientation = Orientation.portrait;

  void changeOrientation(Orientation orientation) {
    this.orientation = orientation;
    // notifyListeners();
  }
}
