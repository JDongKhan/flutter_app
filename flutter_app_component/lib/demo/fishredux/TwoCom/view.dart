import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(TwoComState state, Dispatch dispatch, ViewService viewService) {
  return TextField(
    controller: state.textEditingController,
    decoration: InputDecoration(labelText: "请输入"),
  );
}
