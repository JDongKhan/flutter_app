import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum OnePageAction { action }

class OnePageActionCreator {
  static Action onAction() {
    return const Action(OnePageAction.action);
  }
}
