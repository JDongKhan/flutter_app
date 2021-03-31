import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TwoPageState> buildEffect() {
  return combineEffects(<Object, Effect<TwoPageState>>{
    TwoPageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<TwoPageState> ctx) {
}
