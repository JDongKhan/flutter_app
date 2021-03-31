import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<OnePageState> buildEffect() {
  return combineEffects(<Object, Effect<OnePageState>>{
    OnePageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<OnePageState> ctx) {
}
