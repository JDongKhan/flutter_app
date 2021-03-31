import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TwoComState> buildReducer() {
  return asReducer(
    <Object, Reducer<TwoComState>>{
      TwoComAction.action: _onAction,
    },
  );
}

TwoComState _onAction(TwoComState state, Action action) {
  final TwoComState newState = state.clone();
  return newState;
}
