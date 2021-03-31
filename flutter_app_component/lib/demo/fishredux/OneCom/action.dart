import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum OneComAction { touchAction }

class OneComActionCreator {
  static Action touchAction() {
    return const Action(OneComAction.touchAction);
  }
}
