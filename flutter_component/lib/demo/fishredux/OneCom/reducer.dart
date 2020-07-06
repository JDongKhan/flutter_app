import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<OneComState> buildReducer() {
  return asReducer(
    <Object, Reducer<OneComState>>{
//      OneComAction.action: _onAction,
    },
  );
}

OneComState _onAction(OneComState state, Action action) {
  final OneComState newState = state.clone();
  return newState;
}
