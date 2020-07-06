import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ThreeComState> buildReducer() {
  return asReducer(
    <Object, Reducer<ThreeComState>>{
      ThreeComAction.action: _onAction,
    },
  );
}

ThreeComState _onAction(ThreeComState state, Action action) {
  final ThreeComState newState = state.clone();
  return newState;
}
