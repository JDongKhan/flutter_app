import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ThreeComAction { action }

class ThreeComActionCreator {
  static Action onAction() {
    return const Action(ThreeComAction.action);
  }
}
