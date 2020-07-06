import 'package:fish_redux/fish_redux.dart';

class OneComState implements Cloneable<OneComState> {

  String title;

  OneComState({String title}) {

    if (title == null) {

      this.title = "点击按钮";
    } else {
      this.title = title;
    }
  }

  @override
  OneComState clone() {
    return OneComState()
      ..title = title;
  }
}

OneComState initState(Map<String, dynamic> args) {
  return OneComState();
}
