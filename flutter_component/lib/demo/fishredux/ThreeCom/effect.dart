import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ThreeComState> buildEffect() {
  return combineEffects(<Object, Effect<ThreeComState>>{
    ThreeComAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ThreeComState> ctx) {
}
