import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_component/demo/fishredux/TwoPage/page.dart';

import 'action.dart';
import 'state.dart';

Effect<OneComState> buildEffect() {
  return combineEffects(<Object, Effect<OneComState>>{
    OneComAction.touchAction: _touchAction,
  });
}

void _touchAction(Action action, Context<OneComState> ctx) {
  if (ctx.state.title.contains("返回")) {
    Navigator.of(ctx.context).pop();
  } else {
//    ctx.dispatch(OnePageActionCreator.onAction());
    Navigator.of(ctx.context).push(MaterialPageRoute(
        builder: (_) => TwoPagePage()
            .buildPage({"passString": "passString", "btnTitle": "返回"})));
  }
}
