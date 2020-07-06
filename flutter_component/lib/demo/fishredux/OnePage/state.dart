import 'package:fish_redux/fish_redux.dart';

class OnePageState implements Cloneable<OnePageState> {

  @override
  OnePageState clone() {
    return OnePageState();
  }
}

OnePageState initState(Map<String, dynamic> args) {
  return OnePageState();
}
