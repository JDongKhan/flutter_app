import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TwoComAction { action }

class TwoComActionCreator {
  static Action onAction() {
    return const Action(TwoComAction.action);
  }
}
