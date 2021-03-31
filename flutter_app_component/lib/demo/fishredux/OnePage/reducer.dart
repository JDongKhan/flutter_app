import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<OnePageState> buildReducer() {
  return asReducer(
    <Object, Reducer<OnePageState>>{
      OnePageAction.action: _onAction,
    },
  );
}

OnePageState _onAction(OnePageState state, Action action) {
  final OnePageState newState = state.clone();
  return newState;
}
