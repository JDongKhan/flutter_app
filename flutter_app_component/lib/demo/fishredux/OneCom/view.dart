import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(OneComState state, Dispatch dispatch, ViewService viewService) {
  return FlatButton(onPressed: (){

    dispatch(OneComActionCreator.touchAction());//去执行一个任务

  }, child: Text(state.title));
}
