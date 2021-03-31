import 'package:fish_redux/fish_redux.dart';

class TwoPageState implements Cloneable<TwoPageState> {

  String passString;

  String btnTitle;

  @override
  TwoPageState clone() {
    return TwoPageState()
      ..btnTitle = btnTitle
      ..passString = passString;
  }
}

TwoPageState initState(Map<String, dynamic> args) {

  return TwoPageState()
    ..passString = args["passString"]
    ..btnTitle = args["btnTitle"];
}
