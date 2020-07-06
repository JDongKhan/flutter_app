import 'package:fish_redux/fish_redux.dart';

class ThreeComState implements Cloneable<ThreeComState> {

  String someString = '';

  ThreeComState({this.someString});

  @override
  ThreeComState clone() {
    return ThreeComState()
      ..someString = someString;
  }
}

ThreeComState initState(Map<String, dynamic> args) {
  return ThreeComState();
}
