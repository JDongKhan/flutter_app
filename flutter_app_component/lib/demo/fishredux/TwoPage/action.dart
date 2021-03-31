import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TwoPageAction { action }

class TwoPageActionCreator {
  static Action onAction() {
    return const Action(TwoPageAction.action);
  }
}
