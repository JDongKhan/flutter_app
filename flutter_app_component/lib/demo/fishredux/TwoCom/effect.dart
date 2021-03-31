import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<TwoComState> buildEffect() {
  return combineEffects(<Object, Effect<TwoComState>>{
    TwoComAction.action: _onAction,

  });
}

void _onAction(Action action, Context<TwoComState> ctx) {
}
