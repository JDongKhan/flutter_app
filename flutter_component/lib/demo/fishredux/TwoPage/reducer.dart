import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TwoPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<TwoPageState>>{
      TwoPageAction.action: _onAction,
    },
  );
}

TwoPageState _onAction(TwoPageState state, Action action) {
  final TwoPageState newState = state.clone();
  return newState;
}
